use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Help;

subtest '!tekitou help' => sub {
    my $str = Help->get_text("!tekitou help");
    is $str, '!tekitou: 何か返事を返す
!tekitou help: これを表示
!tekitou tenki [場所]: 場所の天気のURL(livedoor)を表示

マスター、[任意]一杯: 用意して返す
たまに請求書を要求される
[杯枚丁羽個本斗合粒匹玉貫皿巻]に対応
マスター、会計: 会計する
大将、[任意]一杯: マスターと同様
';
};

done_testing;
