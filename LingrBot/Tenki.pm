package Tenki;

use v5.14;
use warnings;
use utf8;
use Encode;

our $VERSION = "0.01";

sub get_text {
    my $class = shift;
    my ($str) = @_;
    $str //= "!tekitou tenki";

    my @search = split(" ", $str);
    return "" if ($search[1] ne "tenki");
    return "" if (!defined $search[2]);

    my $file = "./tenkilink.csv";
    my @data;
    my $text = "";
    open (my $fh, "<", $file)
        or die "Cannot open $file: $!";
    while (my $line = readline $fh) {
        chomp $line;
        @data = split(',',decode_utf8($line));

        if ($data[0] =~ /^$search[2]/) {
            $text = $text . $data[0] . "\n" .
                    $data[1] . "\n";
        }
    }
    close $fh;

    return $text;
}

1;

__END__

