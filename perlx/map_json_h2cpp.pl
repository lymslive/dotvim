#! /usr/bin/env perl
# 从头文件的 struct 定义中生成 cpp 文件的 MAP_JSON 与 MAP_FIELD 宏.
use strict;
use warnings;

while (<>) {
	chomp;
	my $line = $_;
	# 保留空行
	if ($line =~ /^\s*$/) {
		print "\n";
		next;
	}
	# 保留注释行
	if ($line =~ /^\s*\/\//)
	{
		print "$line\n";
		next;
	}

	# 开大括号
	if ($line =~ /^\s*\{\s*$/)
	{
		print "$line\n";
		next;
	}

	# 闭大括号
	if ($line =~ /^\s*\}\s*;\s*$/)
	{
		$line =~ s/;.*//;
		print "$line\n";
		next;
	}

	if ($line =~ /^\s*struct\s+(\w+)/) {
		print "MAP_JSON($1)\n";
		next;
	}

	if ($line =~ /^(\s*)([\w:]+)\s+(\w+)/) {
		print "$1MAP_FIELD($3);\n";
		next;
	}
}

