# t/02_get_param.t
use strict;
use warnings;
use Test::More;
use LingrBot;

my $obj = LingrBot->new();


subtest 'get_speaker_id' => sub {
    my $str = $obj->get_speaker_id;
    is $str, '';
};
subtest 'get_nickname' => sub {
    my $str = $obj->get_nickname;
    is $str, '';
};
subtest 'get_text' => sub {
    my $str = $obj->get_text;
    is $str, '';
};

done_testing;
