#! /usr/bin/perl
# 从 github 网址安装一个 vim 插件仓库
# 唯一参数是从浏览器上复制的 url
# 安装在 ~/.vim/pack/*/opt 目录下，暂只支持 linux
# 如果之前已安装，会提示，确认后执行 git pull
# 否则执行 git clone 

use strict;
use warnings;

my $url = shift;
my $rootdir = "$ENV{HOME}/.vim/pack";
die "may not git resp: $url" if $url !~ m{github\.com/(.+)/(.+)};
my $author = $1;
my $resp = $2;
my $sshurl = "git\@github.com:$author/$resp.git";

my $optdir = "$rootdir/$author/opt";
&oscmd("mkdir -p $optdir") unless -d $optdir;
print "$optdir\n";

chdir($optdir) or die "cannot chdir to $optdir: $!";

my $respdir = "$optdir/$resp";
if (-d $respdir) {
	print "[$respdir] already exists, update? yes[/no]";
	my $reply = <STDIN>;
	if ($reply !~ /^n/i) {
		chdir($respdir) or die "cannot chdir to $respdir: $!";
		oscmd('git pull');
	}
}
else{
	# oscmd("git clone $url");
	oscmd("git clone $sshurl");
	if (-d "$respdir/doc") {
		chdir("$respdir/doc") or die "cannot chdir to $respdir/doc: $!";
		oscmd("vim -u NONE -c 'helptags .' -cq");
	}
}

sub oscmd
{
	my $cmd = shift;
	print "SHELL\$ $cmd\n";
	system($cmd) == 0 or die "system($cmd) failed: $?";
}

