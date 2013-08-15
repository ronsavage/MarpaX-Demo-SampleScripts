use strict;
use warnings;

use Module::Build;

Module::Build -> new
(
	module_name    => 'MarpaX::Demo::JSONParser',
	license        => 'artistic_2',
	dist_abstract  => 'A JSON parser with a choice of grammars',
	dist_author    => 'Ron Savage <ron@savage.net.au>',
	build_requires =>
	{
		'Test::Exception' => 0.31,
		'Test::More'      => 0.94,
#		'Test::Pod'       => 1.45, # Make it optional. See t/pod.t
	},
	configure_requires =>
	{
		'Module::Build' => 0.3800,
	},
	requires =>
	{
		'File::Basename' => 2.82,
		'Marpa::R2'      => 2.058000,
		'Moo'            => 1.002000,
		'Path::Tiny'     => 0.025,
		'Perl6::Slurp'   => 0.051003,
		'strict'         => 0,
		'Try::Tiny'      => 0.16,
		'warnings'       => 0,
	},
) -> create_build_script();
