#!/bin/bash

# This shell script must be run using sudo.


dir=$1
cong=$2
time=$3
delay=$4
maxq=$5
bw=$6
num_flows=$7
time_btwn_flows=$8

last_flow=`expr $num_flows - 1`
oldpwd=$PWD
mkdir -p $dir
rm -rf $dir/*

echo "running $type experiment..."

python flows.py --fig-num 2 --cong $cong --time $time --bw-net $bw --delay $delay --maxq $maxq --num-flows $num_flows --time-btwn-flows $time_btwn_flows --dir $dir

cd $dir
echo "processing flows..."
for i in $(seq 0 $last_flow); do
captcp throughput -u Mbit --stdio flow$i.dmp > captcp$i.txt
awk "{print (\$1+$i*2-1)(\",\")(\$2) }" < captcp$i.txt > captcp-csv$i.txt
done
cd $oldpwd
python plot_throughput.py --xlimit 50 -f $dir/captcp-csv* -o $dir/throughput.png
