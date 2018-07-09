#! /usr/bin/env perl
# 将单行 json 字符串将换为多行缩进打印格式
package jsonbreak;
use strict;
use warnings;

my $input;
{
	local $/ = undef;
	$input = <STDIN>;
	$input =~ s/\n\s*//mg;
}

my $json = $1 if $input =~ m/({.*})/;
exit 0 unless defined $json;
