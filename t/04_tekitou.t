use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Tekitou;

subtest '!tekitou' => sub {
    my $str = Tekitou->get_text("!tekitou");
    is $str, 'コマンド一覧:
hi!
マスター、[任意]一杯
!tekitou tenki [場所]
';
};

done_testing;