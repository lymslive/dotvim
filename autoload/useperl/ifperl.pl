#! /usr/bin/env perl
# package ifperl;
use strict;
use warnings;

sub Hello
{
	print "hell vim if_perl\n";
}

1;
=pod

    :perl require "./ifperl.pl";
    :perl ifperl::Hello();

因为该文件置于 package ifperl 内，不能直接调用 Hello()
采用默认的 main 包就可以。

require 也取决于 perl 的 @INC 搜索路径。可用 uselib 添加搜索路径。
    :perl use lib(".")
=cut
