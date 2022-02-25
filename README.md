# Setup

The experiment setup uses a VBox Virtual Machine running a modified linux kernel on top of Lubuntu 16.04. This setup is modified from https://github.com/bgirardeau/bbr-replication.git. The only prerequisite to run this project is Oracle Virtual Box.

1. First, create a virtual machine called TCP (just for reference, it can be called whatever), using the Lubuntu 16.04 image. It can be obtained from https://cdimage.ubuntu.com/lubuntu/releases/16.04/release/.

When creating the virtual machine, make sure to give it at least 9Gb of hard drive space, as the modified version of the kernel is heavy, and experiments packet traces can take several gigabytes. For this reason, all the traces are deleted after running an experiment. I used 16Gb and 4Gb of RAM.

2. Install Git
```sudo apt-get install -y git```

3. Clone the repository https://github.com/arod40/bbr-reno-comparison into a directory you prefer.

4. Navigate to the project directory.

5. Run ```sed -i -e 's/\r$//' *.sh```. This is to fix the carriage return character introduced by Windows (yes, I use Windows).

6. Run ```sudo chmod +x *.sh```. To give execution permission to the scripts.

7. Run ```sudo ./install_kernel.sh```. This installs the modified linux kernel. It takes around 20 min to complete. At some point it asks for the user password. After the script is completed the computer will reboot.

8. Navigate again to the project directory and run
```sudo ./install_deps.sh```

# Running the experiments

In the repository, several directories named ```exp*``` are found, corresponding to each of the graphics described in the writeup. Each directory must contain a ```setup.sh``` scripts with the parameters set up of the experiment.

Two scripts are needed to run the experiments: ```rtt.sh``` and ```throughput.sh``` for the types of graphics that plot RTT and throughput, respectively. ```exp1, exp2, exp3``` should be run with ```rtt.sh```, and the remaining ones should be run using ```throughput.sh```. To run an experiment just open a terminal, navigate to the project directory, and type in the terminal 

```sudo ./<script> <exp_dir>```

, where ```<script>``` and ```<exp_dir>``` are the script and the experiment directory, respectively.

An experiment with result in an image generated the expriment directory. All the capture and intermediate files are going to be deleted.
