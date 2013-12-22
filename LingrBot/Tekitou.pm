package Tekitou;

use v5.14;
use warnings;
use utf8;
use Encode;
use LingrBot::SinatraAdventCalendar2013;
use LingrBot::Tenki;

our $VERSION = "0.01";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    return "" if (!defined $text);

    my @str = split(' ', $text);

    return "" if ($str[0] ne '!tekitou');
    return "" if (!defined $str[1]);

    my $ret;
    if ($str[1] =~ /sac/) {
        $ret = SinatraAdventCalendar2013->get_text($text);
    } elsif ($str[1] =~ /tenki/) {
        $ret = Tenki->get_text($text);
    }

    return $ret;
}

1;

__END__

