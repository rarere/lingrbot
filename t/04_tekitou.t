use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Tekitou;

subtest 'hi!' => sub {
    my %hash = (
        speaker_id => "dokoka",
        nickname => "dareka",
        text => "hi!",
    );
    my $str = Tekitou->get_text(\%hash);
    is $str, 'hi, dareka!';
};

subtest '!tekitou' => sub {
    my %hash = (
        speaker_id => "dokoka",
        nickname => "dareka",
        text => "!tekitou",
    );
    my $str = Tekitou->get_text(\%hash);
    isnt $str, '';
};

done_testing;
