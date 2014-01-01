use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Tenki;

subtest 'nodata1' => sub {
    my $str = Tenki->get_text();
    is $str, 'Usage: !tekitou tenki [場所]';
};

subtest 'no data2' => sub {
    my $str = Tenki->get_text("!tekitou tenki");
    is $str, 'Usage: !tekitou tenki [場所]';
};

subtest 'dokoka' => sub {
    my $str = Tenki->get_text("!tekitou tenki dokoka");
    is $str, '見つかりませんでした';
};

subtest 'japanese: kure' => sub {
    my $str = Tenki->get_text("!tekitou tenki 呉市");
    is $str, '呉市
http://weather.livedoor.com/area/forecast/3420200
';
};

subtest 'english: sapporo shi' => sub {
    my $str = Tenki->get_text("!tekitou tenki sapporo");
    is $str, '札幌市
http://weather.livedoor.com/area/forecast/0110000
';
};

done_testing;
