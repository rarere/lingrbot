use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Tenki;

subtest 'nodata' => sub {
    my $str = Tenki->get_text();
    is $str, '';
};

subtest 'err str1' => sub {
    my $str = Tenki->get_text("!tekitou tigau dokoka");
    is $str, '';
};

subtest 'err str2' => sub {
    my $str = Tenki->get_text("!tekitou tenki");
    is $str, '';
};

subtest 'kure' => sub {
    my $str = Tenki->get_text("!tekitou tenki 呉市");
    is $str, '呉市
http://weather.livedoor.com/area/forecast/3420200
';
};

subtest 'sapporo shi' => sub {
    my $str = Tenki->get_text("!tekitou tenki 札幌市");
    is $str, '札幌市
http://weather.livedoor.com/area/forecast/0110000
';
};

subtest 'sapporo' => sub {
    my $str = Tenki->get_text("!tekitou tenki 札幌");
    is $str, '道央 札幌 の天気
http://weather.livedoor.com/area/forecast/016010
今日(2013-12-24): 晴のち曇 最低:  最高: 
明日(2013-12-25): 曇時々雪 最低: -3 最高: 2
明後日(2013-12-26): 曇のち雪 最低:  最高: 

札幌市
http://weather.livedoor.com/area/forecast/0110000
';
};

done_testing;
