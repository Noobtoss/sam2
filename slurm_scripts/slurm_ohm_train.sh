#!/bin/bash
#
#SBATCH --job-name=sam2    # Kurzname des Jobs
#SBATCH --output=logs/R-%j.out
#SBATCH --mail-user=thomas.schmitt@th-nuernberg.de
#SBATCH --mail-type=ALL
#
#SBATCH --partition=p2
#SBATCH --qos=gpuultimate
#SBATCH --gres=gpu:1
#SBATCH --nodes=1                # Anzahl Knoten
#SBATCH --ntasks=1               # Gesamtzahl der Tasks über alle Knoten hinweg
#SBATCH --cpus-per-task=4        # CPU Kerne pro Task (>1 für multi-threaded Tasks)
#SBATCH --mem=16G                # RAM pro CPU Kern #20G #32G #64G

mkdir -p logs

module purge
module load python/anaconda3
eval "$(conda shell.bash hook)"

conda activate conda_sam2

srun python training/train.py \
    -c configs/sam2.1_training/semmel_sam2.1_hiera_b+_MOSE_finetune.yaml \
    --use-cluster 0 \
    --num-gpus 1
