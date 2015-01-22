#!/usr/bin/perl -w
#
# NSLW = NetScreen Log Watch
# Author: tbledsoe
#
# To seed the log
#
# zgrep <pattern> <log.0.gz>  > <file>
#
# Usage nslw <flag> <file>
#

$debug = 0; # Set to 1 for verbose output

if ($#ARGV != 1) {die "\nNSLW = NetScreen Log Watch V7\n\nUsage: nslw <flag = src|dst|bth|fwf|fwo> <file>\n\nflags:\n\tsrc = print source IP, protocol, and count\n\tdst = print destination IP, protocol, and count\n\tbth = print source & destination IP, protocol, and count\n\tfwo = print only firewall rules and hit count\n\t fwf = print bth, and firewall:policy_id\n\n";}
$flag = "$ARGV[0]";
#
open (LOG, "< $ARGV[1]") or die "\nCan't open file $ARGV[1]\n";

$count = 0;

while (<LOG>)
        {
        @line = split (/\s+/,$_);
        $key = "";
        $count++;
        if ($debug) {print"\n$count\t";}
        foreach $key (@line)
                {
                if ($key =~ "src=")
                        {
                        $src_ip = "";
                        @tmp = split(/=/,$key,2);
                        $src_ip = $tmp[1];
                        if ($debug) {print"$src_ip\t";}
                        }
                if ($key =~ "dst=")
                        {
                        $dst_ip = "";
                        @tmp = split(/=/,$key,2);
                        $dst_ip = $tmp[1];
                        if ($debug) {print"$dst_ip\t";}
                        }
                if ($key =~ "service=")
                        {
                        $port = "";
                        @tmp = split(/=/,$key,2);
                        $port = $tmp[1];
                        if ($debug) {print"$port\t";}
                        }
                if ($key =~ "device_id=")
                        {
                        $device = "";
                        @tmp = split(/=/,$key,2);
                        $device = $tmp[1];
                        if ($debug) {print"$device\t";}
                        }
                if ($key =~ "policy_id=")
                        {
                        $policy = "";
                        @tmp = split(/=/,$key,2);
                        $policy = $tmp[1];
                        if ($debug) {print"$policy\t";}
                        }
                }
        if ($flag =~ /src/) {$entry = "$src_ip\t$port";}
        elsif ($flag =~ /dst/) {$entry = "$dst_ip\t$port";}
        elsif ($flag =~ /bth/) {$entry = "$src_ip\t$dst_ip\t$port";}
        elsif ($flag =~ /fwf/) {$entry = "$src_ip\t$dst_ip\t$port\t$device:$policy";}
        elsif ($flag =~ /fwo/) {$entry = "$device:$policy";}
        else {die "\nFlag Usage = src, dst, bth, or fw\n\n";}

        if ($debug) {print "$entry\t";}

        if (exists($HITCNT{$entry})) {$HITCNT{$entry}++;}
        else {$HITCNT{$entry} = 1;}
        }
close (LOG);

$total_hits = 0;

foreach $key (sort keys %HITCNT)
        {
        print "$key\t$HITCNT{$key}\n";
        $total_hits = $total_hits + $HITCNT{$key};
        }
$accuracy = 100*$count/$total_hits;
if ($debug) {print "\nLINES = $count\tTotal Hits = $total_hits\t Accuracy = $accuracy%\n";}
