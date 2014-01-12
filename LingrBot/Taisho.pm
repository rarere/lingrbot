package Taisho;

use v5.14;
use warnings;
use utf8;
use Encode;
use DBI;

our $VERSION = "0.03";

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
        $ret = oshinagaki();
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
    my $self = shift;

    my $file = "./taisho.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });
    my $sql = "select menu, price from t_menu order by id asc;";
    my $sth = $dbh->prepare($sql);
    $sth->execute() or die "Error: " . $dbh->errstr;

    my $array;
    while (my $array_ref = $sth->fetchrow_arrayref) {
        my ($menu, $price) = @$array_ref;
        $menu = decode_utf8($menu);
        $array .= "${menu}: ${price}円\n";
    }
    $dbh->disconnect();

    return $array;
}

sub kaikei {
    my $ret = int(rand(10000)) . "円になります";
    return $ret;
}

1;

__END__

