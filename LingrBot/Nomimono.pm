package Nomimono;

use v5.14;
use warnings;
use utf8;

our $VERSION = "0.02";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    $text //= "";

    my $nomimono_text = "";
    if ($text =~ /マスター、(.*)一杯/) {
        $nomimono_text = ippai($1);
    } elsif ($text =~ /会計/) {
        $nomimono_text = kaikei();
    }

    return $nomimono_text;
}

sub ippai {
    my ($text) = @_;
    my $ret = "つ ".$text;
    return $ret;
}

sub kaikei {
    my $ret = int(rand(10000)) . "円になります";
    return $ret;
}

1;

__END__

