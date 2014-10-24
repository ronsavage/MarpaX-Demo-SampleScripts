package MarpaX::Demo::SampleScripts;

use 5.010;
use diagnostics;
use strict;
use utf8;
use warnings;
use warnings  qw(FATAL utf8);    # Fatalize encoding glitches.
use open      qw(:std :utf8);    # Undeclared streams in UTF-8.
use charnames qw(:full :short);  # Unneeded in v5.16.

use Data::Dumper;
use Data::Section;

use Marpa::R2;
use Marpa::R2::HTML;

use Moo;

use POSIX;

use Try::Tiny;

use Types::Standard qw/Any ArrayRef HashRef Int Str/;

our $VERSION = '1.00';

# ------------------------------------------------

sub run
{
	my($self) = @_;

	# Return 0 for success and 1 for failure.

	return 0;

} # End of run.

# ------------------------------------------------

1;

=pod

=head1 NAME

C<MarpaX::Demo::SampleScripts> - A collection of scripts using Marpa::R2

=head1 Synopsis

See scripts/*.pl.

=head1 Description

C<MarpaX::Demo::JSONParser> demonstrates 2 grammars for parsing JSON.

Only 1 grammar is loaded per run, as specified by the C<bnf_file> option to C<< new() >>.

See t/basic.tests.t for sample code.

=head1 Installation

Install C<MarpaX::Demo::JSONParser> as you would for any C<Perl> module:

Run:

	cpanm MarpaX::Demo::JSONParser

or run:

	sudo cpan MarpaX::Demo::JSONParser

or unpack the distro, and then either:

	perl Build.PL
	./Build
	./Build test
	sudo ./Build install

or:

	perl Makefile.PL
	make (or dmake or nmake)
	make test
	make install

=head1 Constructor and Initialization

C<new()> is called as C<< my($parser) = MarpaX::Demo::JSONParser -> new(k1 => v1, k2 => v2, ...) >>.

It returns a new object of type C<MarpaX::Demo::JSONParser>.

Key-value pairs accepted in the parameter list (see corresponding methods for details
[e.g. bnf_file([$string])]):

=over 4

=item o bnf_file aUserGrammarFileName

Specify the name of the file containing your Marpa::R2-style grammar.

See data/json.1.bnf, data/json.2.bnf and data/json.3.bnf for the cases handled by the code.

This option is mandatory.

Default: ''.

=back

=head1 Methods

=head2 parse($string)

Parses the given $string using the grammar whose file name was provided by the C<bnf_file> option to
C<< new() >>.

Dies if the parse fails, or returns the result of the parse if it succeeded.

=head1 Files Shipped with this Module

=head2 Data Files

These JSON grammars are discussed in the L</FAQ> below.

=over 4

=item o share/json.1.bnf

This JSON grammar was devised by Peter Stuifzand.

=item o share/json.2.bnf

This JSON grammar was devised by Jeffrey Kegler.

=item o share/json.3.bnf

This JSON grammar was devised by Jeffrey Kegler.

=back

=head2 Scripts

=over 4

=item o scripts/demo.pl

This program is exactly what is displayed in the L</Synopsis> above.

Before installation of this module, run it with:

	shell> perl -Ilib scripts/demo.pl

And after installation, just use:

	shell> perl scripts/demo.pl

=item o scripts/find.grammars.pl

After installation of the module, run it with:

	shell> perl scripts/find.grammars.pl (Defaults to json.1.bnf)
	shell> perl scripts/find.grammars.pl json.1.bnf

Or use json.2.bnf or json.2.bnf.

It will print the name of the path to given grammar file.

=back

=head1 FAQ

=head2 Where are the grammar files actually installed?

They are not installed (when the source code is) under V 1.00.

From V 1.01 on, I use L<File::ShareDir> and L<Module::Install> to install them.

This a complex topic. Here are some of the issues:

=over 4

=item o Module::Install makes it hard to update *META.* after you update the module's version #

It puts them in the dist but not in the current directory (alongside Makefile.PL, etc).

=item o Install in the user's home directory, using L<File::HomeDir>

Problem: Some CPAN testers run with accounts which don't have home directories.

I have used L<File::HomeDir> when shipping modules, but that problem means I switched to L<File::ShareDir>. But...

=item o Install in a shared directory, using L<File::ShareDir>

Problem: Using L<File::ShareDir> requires L<Module::Install> during installation.

The latter has 77 bugs on RT, although some of them may have been fixed.

Problem: Using L<File::ShareDir> requires using Makefile.PL rather that my preferred choice Build.PL.

Sigh.

Problem: Using L<File::ShareDir> means the grammar files will be installed many directories deep.

Again, this is something I don't like doing. On my machine, there are 13 dir names listed when I run
scripts/find.grammars.pl.

Problem: Using L<Module::Install> by itself does not support author tests.

That needs L<Module::Install::AuthorTests>.

=back

Depite all this, for V 1.01 I've used L<File::ShareDir>. And you can now run:

	shell> perl scripts/find.grammars.pl

This reports the directory into which the grammars were installed.

=head2 Which JSON BNF is best?

This is not really a fair question. They were developed under different circumstances.

=over 4

=item o json.1.bnf is by Peter Stuifzand.

json.1.bnf is the first attempt, when the Marpa SLIF still did not handle utf8. And it's meant to be a practical
grammar. The sophisticated test suite is his, too.

=item o json.2.bnf is by Jeffrey Kegler, the author of L<Marpa::R2>.

json.2.bnf was written later, after Jeffey had a chance to study json.1.bnf. He used it to help optimise Marpa,
but with a minimal test suite, so it had a different purpose.

I (Ron) converted their code into forms suitable for building this module.

=item o json.3.bnf is by Jeffrey Kegler.

He developed this in August, 2014, after recent significant progress in the writing of Marpa.

=head2 Where is Marpa's Homepage?

L<http://savage.net.au/Marpa.html>.

=head2 Are there any articles discussing Marpa?

Yes, many by its author, and several others. See Marpa's homepage, just above, and:

L<The Marpa Guide|http://marpa-guide.github.io/>, (in progress, by Peter Stuifzand and Ron Savage).

L<Parsing a here doc|http://peterstuifzand.nl/2013/04/19/parse-a-heredoc-with-marpa.html>, by Peter Stuifzand.

L<An update of parsing here docs|http://peterstuifzand.nl/2013/04/22/changes-to-the-heredoc-parser-example.html>, by Peter Stuifzand.

L<Conditional preservation of whitespace|http://savage.net.au/Ron/html/Conditional.preservation.of.whitespace.html>, by Ron Savage.

=head1 See Also

L<MarpaX::Demo::StringParser>.

L<MarpaX::Grammar::Parser>.

L<MarpaX::Languages::C::AST>.

=head1 Machine-Readable Change Log

The file Changes was converted into Changelog.ini by L<Module::Metadata::Changes>.

=head1 Version Numbers

Version numbers < 1.00 represent development versions. From 1.00 up, they are production versions.

=head1 Support

Email the author, or log a bug on RT:

L<https://rt.cpan.org/Public/Dist/Display.html?Name=MarpaX::Demo::JSONParser>.

=head1 Author

L<MarpaX::Demo::JSONParser> was written by Ron Savage I<E<lt>ron@savage.net.auE<gt>> in 2013.

Home page: L<http://savage.net.au/>.

=head1 Copyright

Australian copyright (c) 2013, Ron Savage.

	All Programs of mine are 'OSI Certified Open Source Software';
	you can redistribute them and/or modify them under the terms of
	The Artistic License 2.0, a copy of which is available at:
	http://www.opensource.org/licenses/index.html

=cut
