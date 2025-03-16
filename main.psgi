use v5.40;
use Cwd;
use Plack::App::URLMap;
use Plack::Util;

my $urlmap = Plack::App::URLMap->new;
my $cwd = getcwd();

for my $l (qw/A B/) {
    $urlmap->map(
        "/$l" => sub {
            chdir "$cwd/$l";
            my $app = Plack::Util::load_psgi('app.psgi') ;
            return $app->(@_);
        }
    );
}

$urlmap->to_app;
