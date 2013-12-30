package Help;

use v5.14;
use warnings;
use utf8;

our $VERSION = "0.01";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    my $help_text = "";
    if ($text eq "!tekitou help") {
        $help_text = <<"EOS";
後で書く
EOS
    }

    return $help_text;
}

1;

__END__

