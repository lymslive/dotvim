#! /usr/bin/env perl
# let default main package for vim
# package ifperl;
use strict;
use warnings;

## GotFuncName
# print string to stdout, which captured by vim

# send a comma-separated list of @INC path
sub GotIncPath
{
	print join(',', @INC);
}

## Test Function:
#

sub Hello
{
	print "hello vim if_perl\n";
	print "hello $_\n" for @_;
}

sub TestIfperl
{
	my ($var) = @_;
	Hello();
	Hello(qw(AAAA BBBB CCCC));
}

TestIfperl() unless caller;
1;
=pod

    :perl require "./ifperl.pl";
    :perl ifperl::Hello();

因为该文件置于 package ifperl 内，不能直接调用 Hello()
采用默认的 main 包就可以。

require 也取决于 perl 的 @INC 搜索路径。可用 uselib 添加搜索路径。
    :perl use lib(".")
=cut
