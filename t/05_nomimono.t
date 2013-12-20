use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Nomimono;

subtest 'test' => sub {
    my $str = Nomimono->get_text("!tekitou sac 12");
    is $str, '';
};
subtest 'otya' => sub {
    my $str = Nomimono->get_text("マスター、お茶一杯");
    is $str, 'つ お茶';
};


done_testing;
