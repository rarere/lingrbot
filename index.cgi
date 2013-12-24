#!/usr/bin/perl -w

use v5.14;
use warnings;
use utf8;
use LingrBot;
use LingrBot::Tekitou;

my $bot = LingrBot->new();
my $text = $bot->get_text;

if ($text eq 'hi!') {
    my $user = $bot->get_nickname;
    $bot->print_text("hi, $user");
} else {
    my $data = Tekitou->get_text($text);
    $bot->print_text($data);
}

