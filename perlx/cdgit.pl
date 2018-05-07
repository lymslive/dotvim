#! /usr/bin/perl
# 用于辅助快速 cd 到某 git 项目中
# 用法：cdgit basedir/gitname
# 将读取 basedir/git.md ，寻找匹配的 gitname
# 返回其所在全路径字符串
# 因为需要用 shell 函数或语句才能在当前 shell 实际完成 cd
# 如 cd `cdgit.pl name`

use strict;
use warnings;

my $dir = "";
my $name = "";
my $arg = shift;

if ($arg =~ m{(.+)/(.+)}) {
	$dir = $1;
	$name = $2;
} else {
	$dir = $ENV{'PWD'};
	$name = $arg
}

sub getpath()
{
	my $gitreg = qr/^\*\s+(.+):\s+\[(.+)\]/;
	my $dbfile = "$dir/git.md";
	open(my $fh, '<', $dbfile) or die "cannot open $dbfile: $!";
	my %gitpath = ();
	while (<$fh>) {
		chomp;
		next if /^\s*$/;
		next if /^\s*#/;

		if (/$gitreg/) {
			# print "found: $1 = $2\n";
			# 直接返回完全匹配的
			if ($1 eq $name) {
				return $2;
			}
			if (exists $gitpath{$1}) {
				# 重名库，多个路径用 : 分隔
				$gitpath{$1} = $gitpath{$1} . ":$2";
			} else {
				$gitpath{$1} = $2;
			}
		}
	}
	close($fh);

	# 没有完全匹配，按一定策略模糊匹配
	my @names = keys(%gitpath);

	# 忽略大小写
	foreach my $key (@names) {
		if (lc($key) eq lc($name)) {
			return $gitpath{$key};
		}
	}

	# 匹配前缀
	my $re = '^' . lc($name) . '.*';
	# print "try pattern: $re\n";
	foreach my $key (@names) {
		if (lc($key) =~ /$re/) {
			return $gitpath{$key};
		}
	}

	# 匹配中缀
	$re = '.*' . lc($name) . '.*';
	# print "try pattern: $re\n";
	foreach my $key (@names) {
		if (lc($key) =~ /$re/) {
			return $gitpath{$key};
		}
	}

	return "";
}

print getpath();

