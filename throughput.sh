#!/bin/bash

# This shell script must be run using sudo.


dir=$1
cong=$2
time=$3
delay=$4
maxq=$5
bw=$6

oldpwd=$PWD
mkdir -p $dir
rm -rf $dir/*

environment=mininet
flowtype=iperf

echo "running $type experiment..."

destip=`su $SUDO_USER -c "cat ~/.bbr_pair_ip"`
python flows.py --fig-num 6 --cong $cong --time $time --bw-net $bw --delay $delay --maxq $maxq --environment $environment --flow-type $flowtype --dir $dir

cd $dir
echo "processing flows..."
for i in 0 1 2 3 4; do
captcp throughput -u Mbit --stdio flow$i.dmp > captcp$i.txt
awk "{print (\$1+$i*2-1)(\",\")(\$2) }" < captcp$i.txt > captcp-csv$i.txt
done
cd $oldpwd
python plot_throughput.py --xlimit 50 -f $dir/captcp-csv* -o $dir/throughput.png
