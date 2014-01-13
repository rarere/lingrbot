use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Taisho;

subtest 'no reply' => sub {
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

subtest 'oshinagaki' => sub {
    my $str = Taisho->oshinagaki();
    my $str2 = <<EOS;
お茶: 200円
スコッチ: 700円
コーラ: 400円
EOS
    is $str, $str2;
};
subtest 'oshinagaki tsuika error1' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加");
    is $str, "なんもないです";
};
subtest 'oshinagaki tsuika error2' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加 コーラ");
    is $str, "金額ないです";
};
subtest 'oshinagaki tsuika error3' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加 コーラ こーら");
    is $str, "数字じゃないです";
};
subtest 'oshinagaki tsuika ok' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加 コーラ 400");
    is $str, '"コーラ: 400円" を追加しました';
};

done_testing;
