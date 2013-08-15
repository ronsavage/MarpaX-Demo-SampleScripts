use strict;
use warnings;

use Module::Build;

my $class = Module::Build -> subclass(code => <<'EOF');

sub ACTION_authortest
{
	my($self) = @_;

	$self->depends_on('build');
	$self->depends_on('manifest');
	$self->depends_on('distmeta');

	$self->test_files( qw< t xt/author > );
	$self->recursive_test_files(1);

	$self->depends_on('test');

	return;
}
EOF

$class -> new
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
