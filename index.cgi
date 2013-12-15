#!/usr/bin/perl -w

use strict;
use warnings;
use utf8;
use LingrBot;

my $bot = LingrBot->new();
my $user = $bot->get_nickname;
my $text = $bot->get_text;


if ($text eq 'hi!') {
    $bot->print_text("hi, $user");
} else {
    $bot->print_empty();
}

