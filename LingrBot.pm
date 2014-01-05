#!/usr/bin/perl -w
package LingrBot;

use v5.14;
use warnings;
use utf8;
use Encode;
use JSON;
use LingrBot::Tekitou;

our $VERSION = "0.02";

sub new {
    my $class = shift;
    my %args = @_;

    my $json //= '{"status":"", "counter":0, "events":[ {"event_id":0,
       "message": {"id":0, "room":"", "public_session_id":"", "icon_url":"",
           "type":"", "speaker_id":"", "nickname":"", "text":"",
           "timestamp":"", "local_id":""}}]}';
    if (defined $ENV{'CONTENT_LENGTH'}) {
        read(STDIN, $json, $ENV{'CONTENT_LENGTH'});
    }
    $args{json} = decode_json($json);

    my $self = \%args;
    bless $self, $class;

    return $self;
}

sub print_text {
    my $self = shift;

    my %data = (
        speaker_id => $self->{json}->{events}->[0]->{message}->{speaker_id},
        nickname => $self->{json}->{events}->[0]->{message}->{nickname},
        text => $self->{json}->{events}->[0]->{message}->{text},
    );

    my $text = Tekitou->get_text(\%data);
    print "Content-Type: text/plain\n\n";
    print encode_utf8($text);
}


1;

__END__

=encoding utf-8

=head1 NAME

LingrBot - It's new for Lingr Bot

=head1 SYNOPSIS

    use LingrBot;
    my $bot = LingrBot->new();
    $bot->print_text();

=head1 DESCRIPTION

LingrBot is ...

=head1 LICENSE

Copyright (C) rarere.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

rarere E<lt>rarere@savatieri.netE<gt>

=cut

