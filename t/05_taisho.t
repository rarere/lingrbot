use v5.14;
use warnings;
use utf8;
use Test::More;
use LingrBot::Taisho;


subtest 'no args' => sub {
    my $str = Taisho->get_text();
    is $str, '';
};

subtest 'only text' => sub {
    my $str = Taisho->get_text('nanika','');
    is $str, '';
};
subtest 'only nickname' => sub {
    my $str = Taisho->get_text('','dareka');
    is $str, '';
};

subtest 'no reply' => sub {
    my $str = Taisho->get_text("!tekitou sac 12", "dareka");
    is $str, '';
};

subtest 'otya' => sub {
    my $str = Taisho->get_text("マスター、お茶一杯", "dareka");
    is $str, 'つ お茶';
};

subtest 'touhu' => sub {
    my $str = Taisho->get_text("大将、豆腐一丁", "dareka");
    is $str, 'つ 豆腐';
};

subtest 'kaikei' => sub {
    my $str = Taisho->get_text("マスター、会計", "dareka");
    like $str, qr/\d+円になります/;
};

subtest 'oshinagaki' => sub {
    my $str = Taisho->oshinagaki();
    my $str2 = <<EOS;
スコッチ: 700円
コーラ: 400円
EOS
    is $str, $str2;
};
subtest 'oshinagaki tsuika error1' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加", "dareka");
    is $str, "なんもないです";
};
subtest 'oshinagaki tsuika error2' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加 コーラ", "dareka");
    is $str, "金額ないです";
};
subtest 'oshinagaki tsuika error3' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加 コーラ こーら", "dareka");
    is $str, "数字じゃないです";
};
subtest 'oshinagaki tsuika ok' => sub {
    my $str = Taisho->get_text("大将、おしながき 追加 コーラ 400", "dareka");
    is $str, '"コーラ: 400円" を追加しました';
};

done_testing;
