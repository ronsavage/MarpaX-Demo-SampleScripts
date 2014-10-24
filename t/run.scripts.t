use strict;
use warnings;

use Capture::Tiny 'capture';

use File::Slurp; # For read_dir().

use Test::More;

use Try::Tiny;

# ------------------------------------------------

sub run_one
{
	my($script) = @_;

	my($stdout, $stderr);

	try
	{
		($stdout, $stderr) = capture{"$^X $script"};

		ok(1, "Script $script ran");
	}
	catch
	{
		diag "Script $script died: $_\n";
	};

} # End of run_one.

# ------------------------------------------------

my($dir_name) = './scripts';

for my $script (read_dir($dir_name) )
{
	run_one("$dir_name/$script");
}

done_testing;
