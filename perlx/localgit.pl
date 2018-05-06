#! /usr/bin/perl
# 搜索当前目录路径之下（某个子目录）的 git 仓库
# 结果保存在 git.md 文件中，每行数据文件格式：
# * name: [/full/path/of/local](remote url)
# 最深目录层次默认为 5
# 如果有重名仓库在不同子目录下，每个会输出一行记录

use strict;
use warnings;

# my $rootdir = $(pwd);
# my $rootdir = `pwd`; # 可能多个回车
# use Cwd qw(cwd);
# my $rootdir = cwd;
my $rootdir = $ENV{'PWD'};
my $depthmax = 5;
my $DEBUG = 0;

my $GIT = ".git";
my @git = ();
my $OUT = "git.md";

&main();

sub main
{
	my $depth = 1;
	my $basedir = $rootdir;
	my @dirs = subdirs($rootdir);

	# 用一个队列实现宽度搜索
	# 将深度及基准目录也推入队列中，如
	# 1:/root/dir subdirA subdirB 2:/root/dir/subdirA subsub
	while (scalar @dirs > 0) {
		my $dir = shift(@dirs);

		# 特殊项目分隔串
		if ($dir =~ /(\d+):(.+)/) {
			$depth = $1;
			$basedir = $2;
			next;
		}

		# 找到 .git 不再向下搜索
		my $path = "$basedir/$dir";
		if (-d "$path/$GIT") {
			my $entry = foundgit($path, $dir);
			push(@git, $entry);
			next;
		}

		# 再向下搜索子目录，添加到队列末尾
		my $nextdepth = $depth + 1;
		if ($nextdepth <= $depthmax) {
			my $deepin = "$nextdepth:$path";
			push(@dirs, $deepin);
			push(@dirs, subdirs($path));
		}
	}
	
	&output();
}

# 输出找到的 git 列表
sub output
{
	if (scalar @git <= 0) {
		Log("ERR", "not .git resp found");
		return
	}

	open(my $fh, '>', "$rootdir/$OUT") or die "cannot write to $OUT: $!";
	foreach my $entry (@git) {
		print $fh "$entry\n";
	}
	close($fh);

	Log("INFO", "git under $rootdir is saved in $OUT, count:" . (scalar @git));
}

# 返回子目录名列表，不包含本目录基准路径
sub subdirs($)
{
	my $basedir = shift;
	opendir(my $dh, $basedir) or die "cannot opendir $basedir $!";
	my @files = readdir($dh);
	closedir($dh);
	my @dirs = grep { !/^\./ && -d "$basedir/$_"} @files;
	DBGsubdirs($basedir, \@dirs) if $DEBUG;
	return @dirs;
}

sub DBGsubdirs($\@)
{
	my ($basedir, $dirs) = @_;
	my $count = scalar @$dirs;
	my $listr = join(', ', @$dirs);
	# print "[DBG] $basedir = $count [$listr]\n";
	Log("DBG", "$basedir = $count [$listr]");
}


# 在一个已找到 .git 仓库的目录中，返回一条记录
sub foundgit($$)
{
	my $path = shift;
	my $name = shift;
	my $remote = "";
	my $gitcmd = "git -C $path remote -v";
	my $output = `$gitcmd`;
	if ($output =~ /\s+(.+)\s+\(fetch\)/) {
		$remote = $1;
	}
	my $entry = "* $name: [$path]($remote)";
	return $entry;
}

# 简单的日志函数，要求前缀与实际消息两个参数，自动添加换行
sub Log($$)
{
	my ($prifex, $msg) = @_;
	$prifex = "INFO" unless defined $prifex;
	print "[$prifex] $msg\n";
}

=pod
参考博文：perl 的一些重要文件管理工具
https://cn.perlmaven.com/the-most-important-file-system-tools

扩展解释命令行参数： Getopt::Long
http://www.jb51.net/article/34989.htm
=cut
