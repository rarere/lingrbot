#!/usr/bin/perl -w

use v5.14;
use warnings;
use utf8;
use LingrBot;
use LingrBot::Tekitou;
use LingrBot::Nomimono;

my $bot = LingrBot->new();
my $user = $bot->get_nickname;
my $text = $bot->get_text;

my @str = split(/ /, $text);

if ($text eq 'hi!') {
    $bot->print_text("hi, $user");
} elsif ($str[0] eq '!tekitou') {
    my $data = Tekitou->get_text($text);
    $bot->print_text($data);
} elsif ($text =~ /^マスター、/) {
    my $nomimono_text = Nomimono->get_text($text);
    $bot->print_text($nomimono_text);
} else {
    $bot->print_text();
}

