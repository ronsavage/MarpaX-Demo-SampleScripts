package MarpaX::Demo::JSONParser::Actions;

use strict;
use warnings;

# Warning: Do not use Moo or anything similar.
# This class needs a sub new() due to the way
# Marpa calls the constructor.

our $VERSION = 1.00;

# ------------------------------------------------

sub do_array
{
	shift;

	return $_[1];

} # End of do_array.

# ------------------------------------------------

sub do_empty_array
{
	return [];

} # End of do_empty_array.

# ------------------------------------------------

sub do_empty_object
{
	return {};

} # End of do_empty_object.

# ------------------------------------------------

sub do_first_arg
{
	shift;

	return $_[0];

} # End of do_first_arg.

# ------------------------------------------------

sub do_join
{
	shift;

	return join '', @_;

} # End of do_join.

# ------------------------------------------------

sub do_list
{
	shift;

	return \@_;

} # End of do_list.

# ------------------------------------------------

sub do_null
{
	return undef;

} # End of do_null.

# ------------------------------------------------

sub do_object
{
	shift;

	return {map {@$_} @{$_[1]} };

} # End of do_object.

# ------------------------------------------------

sub do_pair
{
	shift;

	return [ $_[0], $_[2] ];

} # End of do_pair.

# ------------------------------------------------

sub do_string
{
	shift;

	my($s) = $_[0];

	$s =~ s/^"//;
	$s =~ s/"$//;

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

} # End of do_string.

# ------------------------------------------------

sub do_true
{
	shift;

	return $_[0] eq 'true';

} # End of do_true.

# ------------------------------------------------

sub new
{
	my($class) = @_;

	return bless {}, $class;

} # End of new.

# ------------------------------------------------

1;
