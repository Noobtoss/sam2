#!/bin/bash -l
#SBATCH --job-name=sam2_train
#SBATCH --output=logs/R-%j.out
#SBATCH --gres=gpu:a100:2
#SBATCH --partition=a100
#SBATCH --constraint=a100_80
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=thomas.schmitt@th-nuernberg.de

mkdir -p logs

BASE_DIR="$WORK/sync/sam2"
DATA_DIR=$TMPDIR

CFG=${1:-"configs/sam2.1_training/semmel_sam2.1_hiera_b+_MOSE_finetune.yaml"}
DATA=${2:-"datasets_tar/Images04train.tar"}

module purge                  # Purge any pre-existing modules
module load python/3.12-conda # Load Python/Conda module
module load cuda/12.6.1       # Load CUDA module for GPU

conda activate conda_sam2

tar xf "$BASE_DIR/$DATA" --strip-components=1 -C $DATA_DIR
echo ErrorMessage unpacking: $?
echo $DATA_DIR

# sed -i "s|^[[:space:]]*data_dir:[[:space:]]*.*|  data_dir: ${DATA_DIR}|" "$BASE_DIR/sam2/$CFG"
# sed -i "s|^[[:space:]]*experiment_name:[[:space:]]*.*|  experiment_name: Images04train|" "$BASE_DIR/sam2/$CFG"

python training/train.py \
    -c configs/sam2.1_training/semmel_sam2.1_hiera_b+_MOSE_finetune.yaml \
    --use-cluster 1 \
    --num-gpus 2 \
    --num-nodes 1 \
    --partition a100 \

#srun python training/train.py \
#    -c $CFG \
#    --use-cluster 0 \
#    --num-gpus 2 \

#python training/train.py \
#    -c $CFG \
#    --use-cluster 0 \
#    --num-gpus 4
