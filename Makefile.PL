use strict;
use warnings;

use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
	($] ge '5.005') ?
	(
		AUTHOR   => 'Ron Savage (ron@savage.net.au)',
		ABSTRACT => 'A JSON parser with a choice of grammars',
	) : (),
	clean =>
	{
		FILES => 'blib/* Makefile MANIFEST MarpaX-Demo-JSONParser-*'
	},
	dist =>
	{
		COMPRESS => 'gzip',
		SUFFIX   => 'gz'
	},
	DISTNAME  => 'MarpaX-Demo-JSONParser',
	NAME      => 'MarpaX::Demo::JSONParser',
	LICENSE   => 'artistic_2',
	PL_FILES  => {},
	PREREQ_PM =>
	{
		'File::Basename'  => 2.82,
		'Marpa::R2'       => 2.058000,
		'Moo'             => 1.002000,
		'Path::Tiny'      => 0.025,
		'Perl6::Slurp'    => 0.051003,
		'strict'          => 0,
		'Test::Exception' => 0.31,
		'Test::More'      => 0.94,
#		'Test::Pod'       => 1.45, # Make it optional. See t/pod.t
		'Try::Tiny'       => 0.16,
		'warnings'        => 0,
	},
	VERSION_FROM => 'lib/MarpaX/Demo/JSONParser.pm',
);
