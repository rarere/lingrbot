# t/04_print.t
use v5.14;
use warnings;
use Test::More;
use LingrBot;

my $obj = LingrBot->new();


subtest 'print_text' => sub {
    my $user = "dareka";
    my $str = $obj->print_text("hi! $user");
    is $str, 1;
};

done_testing;
