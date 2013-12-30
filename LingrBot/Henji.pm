package Henji;

use v5.14;
use warnings;
use utf8;

our $VERSION = "0.01";

sub get_text {
    my $class = shift;

    my @henji_array = (
        "呼ばれたかもしれない",
        "中の人はいないよ!",
        "こんにちは！",
        "どうすればいいんだ",
    );
    return $henji_array[int(rand scalar @henji_array)];
}

1;

__END__

