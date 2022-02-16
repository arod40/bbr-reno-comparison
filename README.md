# Setup

The experiment setup uses two VBox Virtual Machines running a modified linux kernel on top of Lubuntu 16.04.

This setup is modified from https://github.com/bgirardeau/bbr-replication.git

The only prerequisite to run this project is Oracle Virtual Box

First, create two virtual machines called TCP1 and TCP2 (just for reference, they can be called whatever), using the Lubuntu 16.04 image. It can be obtained from https://cdimage.ubuntu.com/lubuntu/releases/16.04/release/. The setup is the same for both machines unless state otherwise.

When creating the virtual machine, make sure to give it at least 9Gb of hard drive space. I used 16Gb and 4Gb of RAM.
Also, add an Internal Network Adapter (leave the NAT adapter so that the machines are able to connect to the Internet).
Once installed the OS, configure the internal network interface and assign IPs manually (different IPs on the same network for each machine).
Install Git (```sudo apt-get install -y git```)
Clone the repository https://github.com/arod40/bbr-reno-comparison into a directory you prefer
Enter the project directory
```sed -i -e 's/\r$//' *.sh```. This is to fix the carriage return character introduced by Windows (yes, I use Windows).
```sudo chmod +x *.sh```. To give execution permission to the scripts.
```./install_kernel.sh```. This installs the modified linux kernel. After the script is completed the computer will reboot.
Go again to the project directory
```./install_deps.sh```

Now, it is needed to link the machines. First, add the TCP1's public key to the list of authorized keys of TCP2. To do that, copy the contents of the TCP1's file ```~/.ssh/id_rsa.pub``` into TCP2's ```~/.ssh/authorized_keys```
Finally, create a file ```~/.bbr_pair_ip``` containing only the IP address assigned to TCP2 in the internal network interface.

# Running the experiments

To run all of the experiments and download the results:
```
# This will run all the three experiments with vm-vm and mininet setup. 
# At the end of this experiment, the figures will be in the folder ./figures/
# This will take roughly 10 minutes to complete.
bash run_experiments.sh 
```

To run individual experiments, log in to the client machine:
```
source settings.sh
gcloud compute ssh --project "$PROJECT" --zone "$ZONE" "$NAME1"
```

On the client machine, you can run `figure5.sh`, `figure6.sh`, or `bonus.sh` individually.
For example,
```
cd bbr-replication
sudo ./figure5.sh [arg] # arg is optional, one of: iperf, netperf, mininet, all (default)
# The figure will be created in ./figure5_[arg]/figure5_[arg].png
```

You can copy the figures to the local machine by running:
```
gcloud compute scp --recurse --project $PROJECT --zone $ZONE $NAME1:~/bbr-replication/path/to/file ./
```
