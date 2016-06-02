#!/usr/bin/perl -pi

use strict;
use warnings;
use Env qw(PREFIX);

BEGIN {undef $/;}

s/^prefix = ./prefix = $PREFIX\n/smg;
s/^am_swiglal_python_la_rpath = -rpath \\.# 	\$\(pkgpyexecdir\)/am_swiglal_python_la_rpath = -rpath \$(pkgpyexecdir)/smg;
