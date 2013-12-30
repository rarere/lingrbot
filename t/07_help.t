use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Help;

subtest '!tekitou help' => sub {
    my $str = Help->get_text("!tekitou help");
    is $str, '後で書く
';
};

done_testing;
