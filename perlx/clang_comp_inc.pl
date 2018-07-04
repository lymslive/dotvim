#! /usr/bin/env perl
# http://bbs.chinaunix.net/thread-4172818-1-1.html
# use v5.14;

use Cwd;
use File::Find::Rule;

my $current_dir      = getcwd();
my @dir_array        = ();
my $config_file_name = "clang_complete.inc";
my $cmd              = "";

@dir_array = File::Find::Rule->directory->in("$current_dir");

$cmd = "rm -rf $config_file_name; touch $config_file_name;";
system($cmd);

foreach my $dir (@dir_array)
{
    $cmd = "echo -I$dir >> $config_file_name;";
    system($cmd);
}

=pod
搜索当前目录下各子目录，添加到 -I 选项而已。
用外不大，似乎。
对已有 g++ make 系统的，把它用到的编译选项复制过去也行
=cut
