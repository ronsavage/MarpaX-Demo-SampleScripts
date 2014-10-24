#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;

use HTML::WikiConverter;

use Marpa::R2::HTML 'html';

#--------------------------

sub fix_tags
{
	my($tagname) = Marpa::R2::HTML::tagname();

	return if (Marpa::R2::HTML::is_empty_element);

	return (Marpa::R2::HTML::start_tag() // "<$tagname>\n") .
			Marpa::R2::HTML::contents() .
			(Marpa::R2::HTML::end_tag() // "</$tagname>\n" );
}

#--------------------------

my($original_html) = 'Text<table><tr><td>I am a cell</table> More Text';
my($valid_html)    = ${html( \$original_html, {'*' => \&fix_tags})};
my($dialect)       = shift || 'DokuWiki';
my($converter)     = HTML::WikiConverter -> new(dialect => $dialect);

say 'Original HTML: ';
say '-'x 50;
say $original_html;
say '-'x 50;
say 'Valid HTML: ';
say '-'x 50;
say $valid_html;
say '-'x 50;
say "$dialect: ";
say '-'x 50;
say $converter -> html2wiki(html => $original_html);
say '-'x 50;

__END__

