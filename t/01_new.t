# t/01_new.t
use v5.14;
use warnings;
use Test::More;
use LingrBot;

subtest 'no args' => sub {
    my $obj = LingrBot->new;
    isa_ok $obj, 'LingrBot';
};

done_testing;
