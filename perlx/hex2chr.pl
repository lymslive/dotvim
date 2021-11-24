#! /usr/bin/env perl
# 将十六进制串转为字符串，不可打印字符统一用点代替
# 每个十六进制字符用空格分格，可能不含前缀 0x
# 读写标准输入输出
package hex2chr;
use strict;
use warnings;

while (<>) {
	chomp;
	my $line = $_;
	foreach my $hex (split(/\s+/, $line)) {
		$hex = hex($hex);
		if ($hex >= 0x20 && $hex <= 0x7F) {
			my $char = chr($hex);
			print $char;
		}
		else {
			print '.';
		}
	}
	print "\n";
}

