use ExtUtils::MakeMaker;

use inc::Module::Install;

# -----------------------------------------------

name 'MarpaX-Demo-JSONParser';

license 'artistic_2';

perl_version '5.014000';

all_from 'lib/MarpaX/Demo/JSONParser.pm';

install_share;

requires 'File::Basename' => 2.82;
requires 'File::ShareDir' => 1.03;
requires 'Marpa::R2'      => 2.082000;
requires 'Moo'            => 1.002000;
requires 'Path::Tiny'     => 0.025;
requires 'Perl6::Slurp'   => 0.051003;
requires 'strict'         => 0;
requires 'Try::Tiny'      => 0.16;
requires 'warnings'       => 0;

test_requires 'Test::Exception' => 0.31;
test_requires 'Test::More'      => 0.98;
#test_requires 'Test::Pod'      => 1.45; # Make it optional. See t/pod.t

recursive_author_tests('xt');

WriteAll;
