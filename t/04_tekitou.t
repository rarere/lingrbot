use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Tekitou;

subtest '!tekitou' => sub {
    my $str = Tekitou->get_text("!tekitou");
    is $str, '呼ばれたかもしれない';
};

done_testing;
