use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::SinatraAdventCalendar2013;

subtest 'exec 12' => sub {
    my $str = SinatraAdventCalendar2013->get_text("!tekitou sac 12");
    is $str, 'Sinatra Advent Calendar 2013 12 日目
5つの理由
http://advent.nzwsch.com/2013/five-reasons
';
};

subtest 'exec mojiretsu' => sub {
    my $str = SinatraAdventCalendar2013->get_text("!tekitou sac 国際化");
    is $str, 'Sinatra Advent Calendar 2013 1 日目
国際化
http://advent.nzwsch.com/2013/internalization
';
};
subtest 'exec mojiretsu kuni' => sub {
    my $str = SinatraAdventCalendar2013->get_text("!tekitou sac 国");
    is $str, 'Sinatra Advent Calendar 2013 1 日目
国際化
http://advent.nzwsch.com/2013/internalization
';
};

subtest 'exec ' => sub {
    my $str = SinatraAdventCalendar2013->get_text();
    is $str, '';
};

done_testing;
