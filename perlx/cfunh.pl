#! /usr/bin/perl
# 从 .h 头文件生成 .cpp 文件
# 根据函数声明生成空实现函数骨架
#
# 输入/输出：标准方式
# 可选参数：
#   可提供一个参数指定默认类名，在分析 .h 文件片断时有用
#   在送入脚本的输入中不包含 class 定义时，取参数作为类名

use strict;
use warnings;

my $defname = shift;
my $clsname = "";
my $funhead = "";
my $funname = "";
my $arglist = "";

while (<STDIN>) {
	chomp;
	if (/^\s*class\s*(\w+)/) {
		$clsname = $1;
		next;
	}
	if (/^\s*(.*?)\s*(~?\w+)\s*\((.*)\)\s*;\s*$/) {
		$funhead = $1;
		$funname = $2;
		$arglist = $3;
		&output;
	}
}

sub output {
	$funhead =~ s/virtual\s+//;
	$funhead =~ s/static\s+//;
	print "$funhead " if $funhead;
	$clsname = $defname unless $clsname;
	print "${clsname}::" if $clsname;
	print "$funname($arglist)\n";
	print "{\n";
	print "\treturn 0;\n" unless $funhead =~ /void/;
	print "}\n";
	print "\n";
}

