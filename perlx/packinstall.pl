#! /usr/bin/perl
# 从 ~/.vim/pack.md 配置文件下载一批插件，安装在 pack 对应的 opt 子目录
# 可从命令行参数指定其他配置文件名
# 配置文件按 markdown 的列表语法，每行给出 github 的网址
#   - 不安装，+ 安装，* 安装并更新
# 也可以在命令直接给出一个网址，单独安装一个插件

use strict;
use warnings;
use File::Path qw(make_path remove_tree);

&checkgit();
my $rootdir = "$ENV{HOME}/.vim/pack";
my $packcfg = "$ENV{HOME}/.vim/pack.md";

# 键为网址，值为是否更新
my %pack = ();
# 并行下载，暂不支持
my $parallel = 0;

##-- MAIN --##
sub main
{
	if (@_) {
		my $arg = shift;
		if ($arg =~ m{https?://}) {
			warn "install one pack from cmd: $arg\n";
			return gitclone($arg, shift);
		}
		elsif (-r $arg){
			warn "use custome pack config file: $arg\n";
			$packcfg = $arg;
		}
	}

	series_install($packcfg);
}

##-- SUBS --##

# 顺序安装所有插件
sub series_install
{
	my $filename = shift;
	open(my $fh, '<', $filename) or die "cannot open $filename $!";
	while (<$fh>) {
		chomp;
		next unless /^[+*]/;
		my @words = split(/\s+/);
		if (scalar @words >= 2) {
			my $update = 0;
			$update++ if $words[0] eq '*';
			my $url = $words[$#words];

			warn "$update --> $url\n";
			$pack{$url} = $update;

			if ($parallel <= 1) {
				gitclone($url, $update);
			}
		}
	}
	close($fh);
}

# 下载一个插件
sub gitclone
{
	my ($url, $update) = @_;
	if ($url !~ m{github\.com/(.+)/(.+)}) {
		warn "may not git resp: $url\n";
		return 0;
	}

	my $author = $1;
	my $resp = $2;
	my $optdir = "$rootdir/$author/opt";
	make_path($optdir) unless -d $optdir;
	warn "$optdir\n";

	unless(chdir($optdir)){
		warn "cannot chdir to $optdir: $!\n";
		return 0;
	}

	my $respdir = "$optdir/$resp";
	if (-d $respdir) {
		if ($update) {
			chdir($respdir) && oscmd('git pull');
		}
	}
	else{
		oscmd("git", "clone", $url);
		if (-d "$respdir/doc") {
			chdir("$respdir/doc") or die "cannot chdir to $respdir/doc: $!";
			oscmd("vim", "-u", "NONE", '-c', 'helptags .', "-cq");
		}
	}

	return 1;
}

# 以列表参数调用一个系统命令
sub oscmd
{
	my @cmd = @_;
	local $, = ' ';
	warn "SHELL\$ @cmd\n";
	system(@cmd) == 0 or warn "system(@cmd) failed: $?\n";
}

# 检查 git 命令及版本
sub checkgit
{
	my $output = `git version` or die "git not install!\n";
	my $version = 0;
	$version = $1 if ($output =~ m/git version ([\d\.]+)/);
	warn "git version < 2.x?\n" if $version lt 1.8;
	return $version;
}

##-- END --##
&main(@ARGV) unless defined caller;
1;
__END__
