package Taisho;

use v5.14;
use warnings;
use utf8;
use Encode;
use DBI;

our $VERSION = "0.06";

sub get_text {
    my $class = shift;
    my ($text, $nickname) = @_;

    $text //= "";
    $nickname //= "";

    if ($text eq "") {
        return "";
    } elsif ($nickname eq "") {
        return "";
    }

    my $taisho_text = "";
    if ($text =~ /^(大将|マスター)、(.*)/) {
        $taisho_text = taisho_message($2, $nickname);
    }

    return $taisho_text;
}

sub taisho_message {
    my ($text, $nickname) = @_;
    my $ret = "";

    if ($text =~ /(.*)一[杯枚丁羽個本斗合粒匹玉貫皿巻]/) {
        $ret = ippai($1, $nickname);
    } elsif ($text =~ /おしながき|お品書き/) {
        $ret = oshinagaki($text);
    } elsif ($text =~ /会計/) {
        $ret = kaikei($nickname);
    }

    return $ret;
}

sub ippai {
    my ($text, $nickname) = @_;

    my $kakaku = get_kakaku($text);
    my $kaikei = add_kaikei($kakaku, $nickname);

    my $ret;
    if ($kaikei < 50000) {
        $ret = "つ " . $text;
    } else {
        $ret = "つ 請求書 ${kakaku}円";
    }
    return $ret;
}

sub get_kakaku {
    my ($text) = @_;
    my $kakaku = 0;

    my $file = "./db/taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });

    my $sql = "select price from t_menu where menu = ?;";
    my $sth = $dbh->prepare($sql);
    $sth->execute($text) or die "Error: " . $dbh->errstr;

    while (my $array_ref = $sth->fetchrow_arrayref) {
        my ($price) = @$array_ref;
        $kakaku = $price;
    }
    $dbh->disconnect();

    # メニューにないものは2000円以内で適当に。
    if ($kakaku == 0) {
        $kakaku = int(rand(2000));
    }

    return $kakaku;
}

sub add_kaikei {
    my ($kakaku, $nickname) = @_;

    my $kaikei = get_kaikei($nickname);
    $kaikei += $kakaku;

    my $file = "./db/taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });
    my $sql = "insert or replace into t_kaikei (nickname, goukei) values (?, ?);";
    my $sth = $dbh->prepare($sql);
    $sth->execute($nickname, $kaikei) or return "Error: " . $dbh->errstr;
    $dbh->disconnect;

    return $kaikei;
}

sub get_kaikei {
    my ($nickname) = @_;

    my $file = "./db/taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });

    my $sql = "select goukei from t_kaikei where nickname = ?;";
    my $sth = $dbh->prepare($sql);
    $sth->execute($nickname) or die "Error: " . $dbh->errstr;

    my $kaikei = 0;
    while (my $array_ref = $sth->fetchrow_arrayref) {
        my ($goukei) = @$array_ref;
        $kaikei = $goukei;
    }
    $dbh->disconnect;
    return $kaikei;
}

sub oshinagaki {
    my ($text) = @_;

    my @str = split(" ", $text);
    my $strlen = @str;

    my $ret;
    if ($strlen == 1) {
        $ret = get_oshinagaki();
    } elsif (defined $str[1] && $str[1] eq "追加") {
        $ret = add_oshinagaki(@str);
    }

    return $ret;
}

sub get_oshinagaki {
    my $file = "./db/taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });

    my $sql = "select distinct menu, price from t_menu order by id asc;";
    my $sth = $dbh->prepare($sql);
    $sth->execute() or die "Error: " . $dbh->errstr;

    my $oshinagaki = "";
    while (my $array_ref = $sth->fetchrow_arrayref) {
        my ($menu, $price) = @$array_ref;
        $menu = decode_utf8($menu);
        $oshinagaki .= "${menu}: ${price}円\n";
    }
    $dbh->disconnect();

    return $oshinagaki;
}

sub add_oshinagaki {
    my (@str) = @_;

    unless (defined $str[2]) {
        return "なんもないです";
    }
    unless (defined $str[3]) {
        return "金額ないです";
    }
    if ($str[3] =~ /\D/) {
        return "数字じゃないです";
    }

    my $file = "./db/taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });

    if (defined $str[4]) {
        my $sql = "insert or replace into t_menu (menu, price, url) values (?, ?, ?);";
        my $sth = $dbh->prepare($sql);
        $sth->execute($str[2], $str[3], $str[4]) or return "Error: " . $dbh->errstr;
    } else {
        my $sql = "insert or replace into t_menu (menu, price) values (?, ?);";
        my $sth = $dbh->prepare($sql);
        $sth->execute($str[2], $str[3]) or return "Error: " . $dbh->errstr;
    }
    $dbh->disconnect;


    return "\"$str[2]: $str[3]円\" を追加しました";
}

sub kaikei {
    my ($nickname) = @_;
    my $kaikei = get_kaikei($nickname) . "円になります";
    update_kaikei($nickname);
    return $kaikei;
}

sub update_kaikei {
    my ($nickname) = @_;

    my $file = "./db/taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });
    my $sql = "insert or replace into t_kaikei (nickname, goukei) values (?, 0);";
    my $sth = $dbh->prepare($sql);
    $sth->execute($nickname) or return "Error: " . $dbh->errstr;
    $dbh->disconnect;

    return 1;
}

1;

__END__

