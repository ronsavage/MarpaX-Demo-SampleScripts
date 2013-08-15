package MarpaX::Demo::JSONParser;

use strict;
use warnings;

use File::Basename; # For basename.

use Marpa::R2;

use MarpaX::Demo::JSONParser::Actions;

use Moo;

use Perl6::Slurp; # For slurp().

has base_name =>
(
	default  => sub {return ''},
	is       => 'rw',
#	isa      => 'Str',
	required => 0,
);

has grammar =>
(
	default  => sub {return ''},
	is       => 'rw',
#	isa      => 'Marpa::R2::Scanless::G',
	required => 0,
);

has scanner =>
(
	default  => sub {return ''},
	is       => 'rw',
#	isa      => 'Marpa::R2::Scanless::R',
	required => 0,
);

has user_bnf_file =>
(
	default  => sub {return ''},
	is       => 'rw',
#	isa      => 'Str',
	required => 1,
);

our $VERSION = 1.00;

# ------------------------------------------------

sub BUILD
{
	my($self)    = @_;
	my $user_bnf = slurp $self -> user_bnf_file, {utf8 => 1};

	$self -> base_name(basename($self -> user_bnf_file) );

	if ($self -> base_name eq 'json.1.bnf')
	{
		$self->grammar
		(
			Marpa::R2::Scanless::G -> new
			({
				action_object  => 'MarpaX::Demo::JSONParser::Actions',
				default_action => 'do_first_arg',
				source         => \$user_bnf,
			})
		)
	}
	elsif ($self -> base_name eq 'json.2.bnf')
	{
		$self->grammar
		(
			Marpa::R2::Scanless::G -> new
			({
				bless_package => 'MarpaX::Demo::JSONParser::Actions',
				source        => \$user_bnf,
			})
		)
	}
	else
	{
		die "Unknown BNF. Use either 'data/json.1.bnf' or 'data/json.2.bnf'\n";
	}

	$self -> scanner
	(
		Marpa::R2::Scanless::R -> new
		({
			grammar => $self -> grammar
		})
	);

} # End of BUILD.

# ------------------------------------------------

sub decode_string
{
	my ($self, $s) = @_;

	$s =~ s/\\u([0-9A-Fa-f]{4})/chr(hex($1))/eg;
	$s =~ s/\\n/\n/g;
	$s =~ s/\\r/\r/g;
	$s =~ s/\\b/\b/g;
	$s =~ s/\\f/\f/g;
	$s =~ s/\\t/\t/g;
	$s =~ s/\\\\/\\/g;
	$s =~ s{\\/}{/}g;
	$s =~ s{\\"}{"}g;

	return $s;

} # End of decode_string.

# ------------------------------------------------

sub eval_json
{
	my($self, $thing) = @_;
	my($type) = ref $thing;

	if ($type eq 'REF')
	{
		return \$self -> eval_json( ${$thing} );
	}
	elsif ($type eq 'ARRAY')
	{
		return [ map { $self -> eval_json($_) } @{$thing} ];
	}
	elsif ($type eq 'MarpaX::Demo::JSONParser::Actions::string')
	{
		my($string) = substr $thing->[0], 1, -1;

		return $self -> decode_string($string) if ( index $string, '\\' ) >= 0;
		return $string;
	}
	elsif ($type eq 'MarpaX::Demo::JSONParser::Actions::hash')
	{
		return { map { $self -> eval_json( $_->[0] ), $self -> eval_json( $_->[1] ) } @{ $thing->[0] } };
	}

	return 1  if $type eq 'MarpaX::Demo::JSONParser::Actions::true';
	return '' if $type eq 'MarpaX::Demo::JSONParser::Actions::false';
	return $thing;

} # End of eval_json.

# ------------------------------------------------

sub parse
{
	my($self, $string) = @_;

	$self -> scanner -> read(\$string);

	my($value_ref) = $self -> scanner -> value;

	die "Parse failed\n" if (! defined $value_ref);

	$value_ref = $self -> eval_json($value_ref) if ($self -> base_name eq 'json.2.bnf');

	return $$value_ref;

} # End of parse.

# ------------------------------------------------

1;
