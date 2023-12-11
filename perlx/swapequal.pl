#! /usr/bin/env perl
# 交换赋值语句左右两端，语句有分号结束。
package swapequal;
use strict;
use warnings;

while (<>) {
	chomp;
	s/^(\s*)(.+?)\s*=\s*(.+?)\s*;\s*$/$1$3 = $2;/;
	print "$_\n";
}

