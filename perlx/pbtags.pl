#! /usr/bin/perl
# 生成 protobuff 描述文件 .proto 源文件中的 tag 列表
#
# 要求 .proto 源文件规范
# 标准输入：.proto 文件名列表，一行一个
# 标准输出：tags 文件内容
#
# 示例用法：
#   ls *.proto | pbtags.pl | sort > tags
#
# tags 文件格式：参考 vim :help tagsrch.txt
#  <tagname><Tab><filename><Tab></search-cmd/>;"<Tab>{:kind}<Tab>{:value}
#
# 提取 tdr-xml 的内容：
# *) message 消息体名，kind='m'
# *) enum  枚举体名，kind='e'
#
# 注意：
# 该脚本生成的 tag 按源文件的顺序输出，如果要排序，可调用其他程序
# 简单的 sort 命令即可按文本行排序
#
# tsl@2018/07

use strict;
use warnings;

# 预编译正则
my $RE_MESSAGE = qr/^\s*message\s+(\w+)/;
my $RE_ENUM = qr/^\s*enum\s+(\w+)/;

# 当前处理的文件
my $FILE = "";

# 统计计数
my %count = (tag => 0, message => 0, enum => 0, );

# --- 主循环程序 --- #
&HandleBegin;
while (<STDIN>)
{
	chomp;
	s/^\s*//;
	s/\s*$//;

	$FILE = $_;
	open BUFF, $FILE or next;

	while (<BUFF>) {
		chomp;
		s/^\s*//;
		s/\s*$//;

		if (/$RE_MESSAGE/) {
			my $msg = $1;
			# my $cmd = '/^\s*message\s\+' . "$msg/";
			my $cmd = "/$_/";
			my $record = tag_record($msg, $FILE, $cmd, 'm');
			print "$record\n";
			$count{tag}++;
			$count{message}++;
		}
		elsif (/$RE_ENUM/) {
			my $enum = $1;
			# my $cmd = '/^\s*enum\s\+' . "$enum/";
			my $cmd = "/$_/";
			my $record = tag_record($enum, $FILE, $cmd, 'e');
			print "$record\n";
			$count{tag}++;
			$count{enum}++;
		}
	}

	close BUFF;
}
&HandleEnd;
# --- 主循环结束 --- #

sub tag_record
{
	my ($tag, $file, $cmd, $kind, $field) = @_;
	my $record = "$tag\t$file\t$cmd;\"\t$kind";
	if (defined $field) {
		foreach my $key (keys %$field) {
			my $value = $field->{$key};
			$record .= "\t$key:$value";
		}
	}
	return $record;
}

# 在打印一行标记行，排序后一般会置顶表示已排序
# 然而，有些 sort 要 export LC_ALL=C 才是严格字符序排列
sub HandleBegin
{
	print <<EOF;
!_TAG_FILE_SORTED	1	/0=unsorted, 1=sorted, 2=foldcase/
EOF
}

# 向标准错误打印一行统计消息
sub HandleEnd
{
	my $line = "find tag:$count{tag} message:$count{message} enum:$count{enum}\n";
	print STDERR $line;
}

1;
__END__
