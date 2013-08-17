#!/usr/bin/env perl

use strict;
use warnings;

use File::ShareDir;

# --------------

my($app_name) = 'MarpaX-Demo-JSONParser';
my($bnf_name) = 'json.1.bnf';
my($path)     = File::ShareDir::dist_file($app_name, $bnf_name);

print "Using: File::ShareDir::dist_file('$app_name', '$bnf_name'): \n";
print "Found: $path\n";
