#!/bin/bash
#SBATCH --account=rrg-aspuru
#SBATCH --gres=gpu:1              # Number of GPU(s) per node
#SBATCH --cpus-per-task=24         # CPU cores/threads
#SBATCH --mem=125000M              # memory per node
#SBATCH --time=0-20:00            # time (DD-HH:MM)
#SBATCH --job-name reinvent-nonstereo

start_time=$SECONDS

module load python/3.8 scipy-stack
module load StdEnv/2020 gcc/9.3.0
module load rdkit/2021.09.3
module load openbabel

source  ~/env/stereogeneration/bin/activate

echo Working on $1
time python main.py --target=$1 --num_workers=24

deactivate

end_time=$SECONDS
duration=$(( $end_time - $start_time ))

echo "stuff took $duration seconds to complete"

deactivate
