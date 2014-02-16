package Tekitou;

use v5.14;
use warnings;
use utf8;
use Encode;
use LingrBot::Henji;
use LingrBot::Taisho;
use LingrBot::Tenki;
use LingrBot::Help;

our $VERSION = "0.05";

sub get_text {
    my $class = shift;
    my ($data) = @_;

    my $speaker_id = $data->{speaker_id};
    my $nickname = $data->{nickname};
    my $text = $data->{text};

    return "" if (!defined $text);

    my $ret = "";

    # 返事
    if ($text eq "hi!") {
        $ret = "hi, " . $data->{nickname} . "!";
    } elsif ($text =~ /^(大将|マスター)、/) {
        $ret = Taisho->get_text($text, $nickname);
    }

    # !tekitou コマンド
    my @str = split(' ', $text);
    if ($ret eq ""  && $str[0] eq '!tekitou') {
        if ($text eq '!tekitou') {
            $ret = Henji->get_text($text);
        } elsif (defined $str[1] && $str[1] eq "tenki") {
            $ret = Tenki->get_text($text);
        } elsif (defined $str[1] && $str[1] eq "help") {
            $ret = Help->get_text($text);
        }
    }

    return $ret;
}

1;

__END__

