#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --time=600:00
#SBATCH --mem=50G

# $1 : gfa file
# $2 : output directory

source /local/env/envconda.sh
conda activate ~/conda/env_minys

/usr/bin/time -v python3 /home/genouest/genscale/cguyomar/conda/env_minys/bin/graph_simplification/enumerate_paths.py $1 $2
