use strict;
use warnings;

use Module::Build;

my $class = Module::Build->subclass(code => <<'EOF');

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
	module_name    => 'MarpaX::Demo::SampleScripts',
	license        => 'artistic_2',
	dist_abstract  => 'A collection of scripts using Marpa::R2',
	dist_author    => 'Ron Savage <ron@savage.net.au>',
	build_requires =>
	{
		'Test::More' => 0.94,
#		'Test::Pod'  => 1.45, # Make it optional. See xt/author/pod.t.
	},
	configure_requires =>
	{
		'Module::Build' => 0.3800,
	},
	meta_merge =>
	{
		resources =>
		{
			repository => 'https://github.com/ronsavage/MarpaX-Demo-SampleScripts',
		},
	},
	requires =>
	{
		'Capture::Tiny'   => 0.25,
		'charnames'       => 0,
		'Data::Dumper'    => 2.145,
		'Data::Section'   => 0.200006,
		'diagnostics'     => 0,
		'File::Slurp'     => 9999.19,
		'Marpa::R2'       => 2.096000,
		'Marpa::R2::HTML' => 2.096000,
		'Moo'             => 1.006001,
		'open'            => 0,
		'perl'            => 5.010,
		'POSIX'           => 1.32,
		'strict'          => 0,
		'Try::Tiny'       => 0.22,
		'Types::Standard' => 1.000004,
		'utf8'            => 0,
		'warnings'        => 0,
	},
	resources =>
	{
		bugtracker => 'https://rt.cpan.org/Public/Dist/Display.html?Name=MarpaX-Demo-SampleScripts',
		license    => 'http://opensource.org/licenses/Artistic-2.0',
	},
) -> create_build_script();
