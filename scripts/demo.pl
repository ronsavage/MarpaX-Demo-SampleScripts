#!/usr/bin/env perl

use strict;
use warnings;

use File::ShareDir;

use MarpaX::Demo::JSONParser;

use Try::Tiny;

my($app_name) = 'MarpaX-Demo-JSONParser';
my($bnf_name) = shift || 'json.1.bnf'; # Or 'json.2.bnf'.
my($bnf_file) = File::ShareDir::dist_file($app_name, $bnf_name);
my($string)   = '{"test":"1.25e4"}';

my($result);

# Use try to catch die.

try
{
	$result = MarpaX::Demo::JSONParser -> new(bnf_file => $bnf_file) -> parse($string);
};

print $result ? "Result: test => $$result{test}. Expect: 1.25e4. \n" : "Parse failed. \n";
