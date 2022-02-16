# Setup

The experiment setup uses two Google cloud VMs running a modified linux kernel. We
provide a simple install script to create the VMs and install all needed
dependencies.

The setup is modified from https://github.com/google/bbr/blob/master/Documentation/bbr-quick-start.md

The setup script uses gcloud commandline tools, so first install those following the
instructions at: https://cloud.google.com/sdk/downloads 

Login to a gcloud project:
```
gcloud auth login
```

By default, the script uses a new "bbr-replication" Google cloud project for the VMs,
but you can change this by modifying `settings.sh`

Run the script to create the VMs:
```
# This script will take roughly 30 minutes to complete.
# You may need to interact with 1 or 2 prompts at the beginning when it
# launches the VMs
bash create_vms.sh
```

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
