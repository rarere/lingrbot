package Taisho;

use v5.14;
use warnings;
use utf8;

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

sub kaikei {
    my $ret = int(rand(10000)) . "円になります";
    return $ret;
}

1;

__END__

