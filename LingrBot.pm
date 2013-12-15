#!/usr/bin/perl -w
package LingrBot;

use 5.016003;
use strict;
use warnings;

our $VERSION = "0.01";

use utf8;
use Encode;
use JSON;

sub new {
    my $class = shift;
    my %args = @_;

    my $data //= '{"status":"", "counter":0, "events":[ {"event_id":0,
       "message": {"id":0, "room":"", "public_session_id":"", "icon_url":"",
           "type":"", "speaker_id":"", "nickname":"", "text":"",
           "timestamp":"", "local_id":""}}]}';
    if (defined $ENV{'CONTENT_LENGTH'}) {
        read(STDIN, $data, $ENV{'CONTENT_LENGTH'});
    }
    $args{json}   = decode_json($data);

    my $self = \%args;
    bless $self, $class;

    return $self;
}

sub get_speaker_id {
    my $self = shift;
    my $json = $self->{json};
    return $json->{events}->[0]->{message}->{speaker_id};
}
sub get_text {
    my $self = shift;
    return $self->{json}->{events}->[0]->{message}->{text};
}
sub print_text {
    my $self = shift;
    my $text = shift;
    print "Content-Type: text/plain\n\n";
    print "$text\n";
}
sub print_empty {
    my $self = shift;
    print "Content-Type: text/plain\n\n";
    print "";
}



1;

__END__

=encoding utf-8

=head1 NAME

LingrBot - It's new for Lingr Bot

=head1 SYNOPSIS

    use LingrBot;

=head1 DESCRIPTION

LingrBot is ...

=head1 LICENSE

Copyright (C) rarere.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

rarere E<lt>rarere@savatieri.netE<gt>

=cut

