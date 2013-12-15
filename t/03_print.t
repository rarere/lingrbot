# t/04_print.t
use strict;
use warnings;
use Test::More;
use LingrBot;

my $obj = LingrBot->new();


subtest 'print_text' => sub {
    my $user = "dareka";
    my $str = $obj->print_text("hi! $user");
    is $str, 1;
};
subtest 'print_empty' => sub {
    my $str = $obj->print_empty();
    is $str, 1;
};

done_testing;
