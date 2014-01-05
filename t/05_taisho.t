use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Taisho;

subtest 'test' => sub {
    my $str = Taisho->get_text("!tekitou sac 12");
    is $str, '';
};

subtest 'otya' => sub {
    my $str = Taisho->get_text("マスター、お茶一杯");
    like $str, qr/つ (お茶|請求書)/;
};
subtest 'touhu' => sub {
    my $str = Taisho->get_text("大将、豆腐一丁");
    like $str, qr/つ (豆腐|請求書)/;
};

subtest 'kaikei' => sub {
    my $str = Taisho->get_text("マスター、会計");
    like $str, qr/\d+円になります/;
};



done_testing;
