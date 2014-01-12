package Help;

use v5.14;
use warnings;
use utf8;

our $VERSION = "0.02";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    my $help_text = "";
    if ($text eq "!tekitou help") {
        $help_text = <<"EOS";
!tekitou: 何か返事を返す
!tekitou help: これを表示
!tekitou tenki [場所]: 場所の天気のURL(livedoor)を表示

マスター、[任意]一杯: 用意して返す
たまに請求書を要求される
[杯枚丁羽個本斗合粒匹玉貫皿巻]に対応
マスター、会計: 会計する
大将、[任意]一杯: マスターと同様
大将、(お品書き|おしながき).*: お品書き一覧を表示
EOS
    }

    return $help_text;
}

1;

__END__

