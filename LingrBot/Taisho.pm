package Taisho;

use v5.14;
use warnings;
use utf8;
use Encode;
use DBI;

our $VERSION = "0.04";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    $text //= "";

    my $taisho_text = "";
    if ($text =~ /^(大将|マスター)、(.*)/) {
        $taisho_text = taisho_message($2);
    }

    return $taisho_text;
}

sub taisho_message {
    my ($text) = @_;
    my $ret = "";

    if ($text =~ /(.*)一[杯枚丁羽個本斗合粒匹玉貫皿巻]/) {
        $ret = ippai($1);
    } elsif ($text =~ /おしながき|お品書き/) {
        $ret = oshinagaki($text);
    } elsif ($text =~ /会計/) {
        $ret = kaikei();
    }

    return $ret;
}

sub ippai {
    my ($text) = @_;
    my $num = rand(100);

    my $ret;
    if ($num < 80) {
        $ret = "つ ".$text;
    } else {
        $ret = "つ 請求書";
    }
    return $ret;
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
    my $file = "./taisho.db";
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

    my $file = "./taisho.db";
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
    my $ret = int(rand(10000)) . "円になります";
    return $ret;
}

1;

__END__

