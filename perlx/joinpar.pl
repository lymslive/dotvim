#! /usr/bin/env perl
# 合并段落
use strict;
use warnings;

my $last_line = '';

while (<>) {
    chomp;
    my $line = $_;
    if (length($line) == 0) {
        print "$last_line\n";
        print "\n";
        $last_line = $line;
    }
    elsif ($line =~ /^\s*\*/) {
        print "$last_line\n" if $last_line;
        $last_line = $line;
    }
    elsif ($line =~ /^\s*\d+\./) {
        print "$last_line\n" if $last_line;
        $last_line = $line;
    }
    else {
        $last_line .= "$line";
    }
}

if (length($last_line) > 0) {
    print "$last_line\n";
}

