package Tekitou;

use v5.14;
use warnings;
use utf8;
use Encode;
use LingrBot::Henji;
use LingrBot::Taisho;
use LingrBot::Tenki;
use LingrBot::Help;

our $VERSION = "0.03";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    return "" if (!defined $text);

    my @str = split(' ', $text);
    my $ret = "";

    # 返事
    if ($text eq "!tekitou") {
        $ret = Henji->get_text($text);
        return $ret;
    }

    # !tekitou コマンド
    if ($str[0] eq '!tekitou') {
        if (defined $str[1] && $str[1] eq "tenki") {
            $ret = Tenki->get_text($text);
        } elsif (defined $str[1] && $str[1] eq "help") {
            $ret = Help->get_text($text);
        }
    } elsif ($text =~ /^(大将|マスター)、/) {
        $ret = Nomimono->get_text($text);
    }

    return $ret;
}

1;

__END__

