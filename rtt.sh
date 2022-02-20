#!/bin/bash

# This shell script must be run using sudo.

dir=$1
source $dir/setup.sh

oldpwd=$PWD
mkdir -p $dir
rm -f $dir/*.png

flow=1

echo "running $type experiment..."
python flows.py --fig-num 1 --time $time --bw-net $bw --delay-min $delay_min --delay-max $delay_max --maxq $maxq --dir $dir
chmod -R 0777 $dir
su $SUDO_USER -c "tshark -2 -r $dir/flow_bbr.dmp -R 'tcp.stream eq $flow && tcp.analysis.ack_rtt'  -e frame.time_relative -e tcp.analysis.ack_rtt -Tfields -E separator=, > $dir/bbr_rtt.txt"
su $SUDO_USER -c "tshark -2 -r $dir/flow_reno.dmp -R 'tcp.stream eq $flow && tcp.analysis.ack_rtt'  -e frame.time_relative -e tcp.analysis.ack_rtt -Tfields -E separator=, > $dir/reno_rtt.txt"

python plot_ping.py -f $dir/bbr_rtt.txt $dir/reno_rtt.txt --xlimit 8 -o $dir/rtt.png

rm $dir/*.txt $dir/*.dmp
