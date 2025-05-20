#!/bin/bash -l
#SBATCH --job-name=slurm_test
#SBATCH --output=logs/R-%j.out
#SBATCH --gres=gpu:a100:2
#SBATCH --partition=a100
#SBATCH --cpus-per-task=4
#SBATCH --time=00:26:10
#SBATCH --mail-type=ALL
#SBATCH --mail-user=thomas.schmitt@th-nuernberg.de

mkdir -p logs

unset SLURM_EXPORT_ENV

module purge
module load python/3.12-conda
module load cuda/12.6.1

conda activate conda_sam2

srun python python_scripts/test_cuda.py
