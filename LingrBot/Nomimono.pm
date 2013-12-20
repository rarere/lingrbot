package Nomimono;

use v5.14;
use warnings;
use utf8;

our $VERSION = "0.01";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    $text //= "";

    my $nomimono_text = "";
    if ($text =~ /マスター、(.*)一杯/) {
        $nomimono_text = "つ ".$1;
    }

    return $nomimono_text;
}

1;

__END__

