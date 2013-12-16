# t/04_sinatra.t
use strict;
use warnings;
use Test::More;
use SinatraAdventCalendar2013;


subtest 'get_text' => sub {
    my $obj = SinatraAdventCalendar2013->new();
    my $str = $obj->get_text;
    is $str, '';
};
subtest 'get_text 12' => sub {
    my $obj = SinatraAdventCalendar2013->new(day => "12");
    my $str = $obj->get_text;
    is $str, 'Sinatra Advent Calendar 2013 12 日目
5つの理由
http://advent.nzwsch.com/2013/five-reasons';
};

done_testing;
