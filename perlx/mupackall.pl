#! /usr/bin/perl
# 以多进程并行方式下载插件
package packall;
use strict;
use warnings;
use POSIX 'WNOHANG';
use File::Path qw(make_path remove_tree);
use Getopt::Long;

&checkgit();
# 默认参数
my $rootdir = "$ENV{HOME}/.vim/pack";
my $packcfg = "$ENV{HOME}/.vim/pack.md";
my $parallel = 1;

# 命令行参数
my ($rootdir_opt, $packcfg_opt, $parallel_opt);
GetOptions('dir=s' => \$rootdir_opt, 
	'cfg=s' => \$packcfg_opt, 
	'fork=i' => \$parallel_opt)
	or die "unknown options\n";
$rootdir = $rootdir_opt if $rootdir_opt;
$packcfg = $packcfg_opt if $packcfg_opt;
$parallel = $parallel_opt if $parallel_opt;

# 从配置文件中提取的有效行记录
my @records = ();

# 子进程管理
my $child = 0;
my %child = ();

# 终止信号
my $quit = 0;
$SIG{INT} = $SIG{TERM} = sub {$quit++;};
# 收割子进程
# $SIG{CHLD} = sub {1 while(waitpid(-1, WNOHANG) >0);};
$SIG{CHLD} = \&reaper;
sub reaper
{
	while ((my $kid = waitpid(-1, WNOHANG)) > 0) {
		$child--;
		delete $child{$kid};
	}
}

##-- MAIN --##
sub main
{
	parse_cfg($packcfg);
	
	foreach my $line (@records) {
		last if $quit > 0;
		sleep(1) while($child >= $parallel);

		warn "parent $$ dispatch work: $line\n";
		my $fpid = fork;
		next unless (defined $fpid);
		if ($fpid > 0) {
			$child++;
			$child{$fpid} = 1;
			local $, = ' ';
			my @live = keys(%child);
			warn "fork $fpid; now $child childs: @live\n";
		}
		else {
			child_work($line);
			exit 0;
		}
	}
	
	sleep while($child > 0 && !$quit);
}

##-- SUBS --##

# 分析配置文件，提取待处理行
sub parse_cfg
{
	my $filename = shift;
	open(my $fh, '<', $filename) or die "cannot open $filename $!";
	while (<$fh>) {
		chomp;
		next unless /^[+*]/;
		push(@records, $_);
	}
	close($fh);
}

# 工作子进程
sub child_work
{
	my ($line) = @_;
	warn "  child $$ deal work: $line\n";
	# sleep(rand 3);
	my @words = split(/\s+/, $line);
	if (scalar @words >= 2) {
		my $update = 0;
		$update++ if $words[0] eq '*';
		my $url = $words[$#words];
		warn "$update --> $url\n";
		gitclone($url, $update);
	}
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
	my $sshurl = "git\@github.com:$author/$resp.git";
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
		# oscmd("git", "clone", $url);
		oscmd("git", "clone", $sshurl);
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

为每个插件地址，fork 了该脚本一个子进程，在子进程中再调用 git clone 系统命令。
可实现并行下载，只不过屏幕输出有点乱。也没法报告连接失败的。
