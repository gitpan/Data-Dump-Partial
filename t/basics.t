#!perl -T

use strict;
use warnings;

use Test::More tests => 26;
use Data::Dump::Partial qw(dump_partial dumpp);

#use lib "./t";
#require "testlib.pl";

is(dump_partial(1), 1, "export dump_partial");
is(dumpp(1), 1, "export dumpp");

is(dumpp("a" x   10, {max_total_len=>10}), '"' . ("a" x 6) . '...', "option max_total_len=10");
is(dumpp(("a" x 100)."1", {max_total_len=>0, max_len=>0}), '"' . ("a" x  100) . '1"', "option max_total_len=0");

is(dumpp("a" x  10), '"' . ("a" x 10) . '"', "untruncated scalar");
is(dumpp("a" x 100), '"' . ("a" x 29) . '..."', "truncated scalar");
is(dumpp("a" x 100, {max_len=>10}), '"' . ("a" x  7) . '..."', "option max_len=10");
is(dumpp(("a" x 50)."1", {max_len=>0}), '"' . ("a" x  50) . '1"', "option max_len=0");

is(dumpp([qw/q w e r t/]), '["q", "w", "e", "r", "t"]', "untruncated array");
is(dumpp([qw/q w e r t y/]), '["q", "w", "e", "r", "t", ...]', "truncated array");
is(dumpp([qw/q w e r t y/], {max_elems=>3}), '["q", "w", "e", ...]', "option max_elems=3");
is(dumpp([qw/q w e r t y/], {max_elems=>0}), '["q", "w", "e", "r", "t", "y"]', "option max_elems=0");

is(dumpp({qw/q 1 w 1 e 1 r 1 t 1/}), '{ e => 1, q => 1, r => 1, t => 1, w => 1 }', "untruncated hash");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}), '{ e => 1, q => 1, r => 1, t => 1, y => 1, ... }', "truncated hash");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>3}), '{ q => 1, r => 1, t => 1, ... }', "option max_keys=3");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>0}), '{ e => 1, q => 1, r => 1, t => 1, w => 1, y => 1 }', "option max_keys=0");

is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>3, worthless_keys=>[qw/q w e/]}), '{ r => 1, t => 1, y => 1, ... }', "option worthless_keys");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>3, precious_keys=>[qw/q w/]}), '{ q => 1, t => 1, w => 1, ... }', "option precious_keys (2)");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>3, precious_keys=>[qw/q w e/]}), '{ e => 1, q => 1, w => 1, ... }', "option precious_keys (3)");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>3, precious_keys=>[qw/q w e r/]}), '{ e => 1, q => 1, r => 1, w => 1, ... }', "option precious_keys (4)");
is(dumpp({qw/q 1 w 1 e 1 r 1 t 1 y 1/}, {max_keys=>3, hide_keys=>[qw/q w e/], worthless_keys=>[qw/r/]}), '{ r => 1, t => 1, y => 1, ... }', "option hide_keys");

is(dumpp({qw/q 1 w 1 e 1 r 1 t 1/}, {max_keys=>1, dd_filter=>sub { return {dump=>"QWERT"}}}), 'QWERT', "option dd_filter");

is(dumpp([2, 4, 6, 8, "a"x33, 12]), '[2, 4, 6, 8, "'.("a"x29).'...", ...]', "nested scalar");
is(dumpp([2, 4, 6, 8, [2, 4, 6, 8, 10, 12], 12]), '[2, 4, 6, 8, [2, 4, 6, 8, 10, ...], ...]', "nested array");
is(dumpp([2, 4, 6, 8, {qw/q 1 w 1 e 1 r 1 t 1 y 1/}, 12]), '[2, 4, 6, 8, { e => 1, q => 1, r => 1, t => 1, y => 1, ... }, ...]', "nested hash");

my $a = {a=>1}; $a->{b} = $a; is(dumpp($a), q|do { my $a = { a => 1, b => 'fix' }; $a->{b} = $a; $a; }|, "remove newlines & indents");