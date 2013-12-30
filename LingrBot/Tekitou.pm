package Tekitou;

use v5.14;
use warnings;
use utf8;
use Encode;
use LingrBot::Nomimono;
use LingrBot::Tenki;
use LingrBot::Help;

our $VERSION = "0.03";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    return "" if (!defined $text);

    my @str = split(' ', $text);

    if ($text eq "!tekitou") {
        my $ret = "呼ばれたかもしれない";
        return $ret;
    }

    my $ret = "";
    if ($str[0] eq '!tekitou') {
        if ($str[1] eq "tenki") {
            $ret = Tenki->get_text($text);
        } elsif ($str[1] eq "help") {
            $ret = Help->get_text($text);
        }
    } elsif ($text =~ /^マスター、/) {
        $ret = Nomimono->get_text($text);
    }

    return $ret;
}

1;

__END__

