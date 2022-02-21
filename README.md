# Setup

The experiment setup uses a VBox Virtual Machine running a modified linux kernel on top of Lubuntu 16.04.

This setup is modified from https://github.com/bgirardeau/bbr-replication.git

The only prerequisite to run this project is Oracle Virtual Box

First, create a virtual machine called TCP (just for reference, it can be called whatever), using the Lubuntu 16.04 image. It can be obtained from https://cdimage.ubuntu.com/lubuntu/releases/16.04/release/.

When creating the virtual machine, make sure to give it at least 9Gb of hard drive space, as the modified version of the kernel is heavy, and experiments packet traces can take several gigabytes. For this reason, all the traces are deleted after running an experiment. I used 16Gb and 4Gb of RAM.
Install Git (```sudo apt-get install -y git```)
Clone the repository https://github.com/arod40/bbr-reno-comparison into a directory you prefer
Enter the project directory
```sed -i -e 's/\r$//' *.sh```. This is to fix the carriage return character introduced by Windows (yes, I use Windows).
```sudo chmod +x *.sh```. To give execution permission to the scripts.
```./install_kernel.sh```. This installs the modified linux kernel. After the script is completed the computer will reboot.
Go again to the project directory
```./install_deps.sh```

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
