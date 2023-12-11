#! /usr/bin/env perl
# 将 tab 分隔或逗号分隔(csv)的行，转为 markdown table 标记。
# 主要是把分隔符替换为 | ，再加一行表头 --|--|-- 满足格式要求。
# 自动识别 tab 或 csv ，优先 tab 。只支持简单 csv ，
# 不判断引号内容包含的逗号。
package marktab;
use strict;
use warnings;

my $csv = ',';
my $tab = '\t';
my $sep = '';

while (<>) {
	chomp;
	my $line = $_;
	if ($sep) {
		$line =~ s/$sep/|/g;
		print "$line\n";
	}
	else {
		if ($line =~ /$tab/) {
			$sep = $tab;
		}
		elsif ($line =~ /$csv/) {
			$sep = $csv;
		}
		
		# 第一次解析表头
		if ($sep) {
			$line =~ s/$sep/|/g;
			print "$line\n";
			my $head = $line;
			$head =~ s/[^|]/-/g;
			print "$head\n";
		}
	}
}

