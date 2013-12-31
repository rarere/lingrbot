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

subtest 'kaikei' => sub {
    my $str = Nomimono->get_text("マスタ、会計");
    like $str, qr/\d+円になります/;
};



done_testing;
