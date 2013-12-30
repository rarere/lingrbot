use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Henji;

subtest '!tekitou' => sub {
    my $str = Henji->get_text("!tekitou help");
    isnt $str, '';
};

done_testing;
