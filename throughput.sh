#!/bin/bash

# This shell script must be run using sudo.


dir=$1
source $dir/setup.sh

last_flow=`expr $num_flows - 1`
oldpwd=$PWD
rm -f $dir/*.png

echo "running $type experiment..."

python flows.py --fig-num 2 --cong $cong --time $time --bw-net $bw --delay-min $delay_min --delay-max $delay_max --maxq $maxq --num-flows $num_flows --time-btwn-flows $time_btwn_flows --flow-type $flow_type --dir $dir

cd $dir
echo "processing flows..."
for i in $(seq 0 $last_flow); do
captcp throughput -u Mbit --stdio flow$i.dmp > captcp$i.txt
awk "{print (\$1+$i*$time_btwn_flows-1)(\",\")(\$2) }" < captcp$i.txt > captcp-csv$i.txt
done
cd $oldpwd
python plot_throughput.py --time-btwn-flows $time_btwn_flows --xlimit $time -f $dir/captcp-csv* -o $dir/throughput.png

rm -f $dir/*.txt $dir/*.dmp
