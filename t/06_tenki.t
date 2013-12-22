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

subtest 'sapporo' => sub {
    my $str = Tenki->get_text("!tekitou tenki 札幌");
    is $str, '札幌市
http://weather.livedoor.com/area/forecast/0110000
';
};


done_testing;
