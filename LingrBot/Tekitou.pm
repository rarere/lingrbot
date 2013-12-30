package Tekitou;

use v5.14;
use warnings;
use utf8;
use Encode;
use LingrBot::Nomimono;
use LingrBot::Tenki;

our $VERSION = "0.02";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    return "" if (!defined $text);

    my @str = split(' ', $text);

    if ($text eq "!tekitou") {
        my $ret = <<EOS;
コマンド一覧:
hi!
マスター、[任意]一杯
!tekitou tenki [場所]
EOS
        return $ret;
    }

    my $ret = "";
    if ($str[0] eq '!tekitou') {
        if ($str[1] =~ /tenki/) {
            $ret = Tenki->get_text($text);
        }
    } elsif ($text =~ /^マスター、/) {
        $ret = Nomimono->get_text($text);
    }

    return $ret;
}

1;

__END__

