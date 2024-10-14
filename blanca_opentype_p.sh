#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --partition=blanca-curc-gpu
#SBATCH --gres=gpu:1
#SBATCH --output=Crowd_test_bin3-%j.out
#SBATCH --mail-type="ALL"
#SBATCH --mail-user="asum8093@colorado.edu"

module purge

module load anaconda
module load cuda/12.1.1
cd /rc_scratch/asum8093/open_type_p/

#wget http://nlp.cs.washington.edu/entity_type/data/ultrafine_acl18.tar.gz

tar -xvzf ultrafine_acl18.tar.gz

#cd ../

mkdir open_type
mv release open_type/

#cp Unsupervised_OpenType/bin_1.json open_type/release/crowd/
#cp Unsupervised_OpenType/bin_2.json open_type/release/crowd/
#cp Unsupervised_OpenType/bin_3.json open_type/release/crowd/
cp Unsupervised_OpenType/bin_4.json open_type/release/crowd/

conda activate py38-pt1131-cuda117

pip install stanza
pip install sentence-transformers
pip install inflect
echo "-----------------"
pwd


echo "====== Running The Model ========"

mkdir Unsupervised_OpenType/predictions_jobimtext

bash Unsupervised_OpenType/scripts/open_type_et_with_jobimtext.sh

cd ./open_type/
git clone https://github.com/uwnlp/open_type.git

cd ./open_type/
#python scorer.py Unsupervised_OpenType/predictions_jobimtext/predictions_open_type_with_jobimtext
#python scorer.py Unsupervised_OpenType/predictions_jobimtext/predictions_test_open_type_with_jobimtext_headword_prepro_includeisas_inclmentionsim_5050

echo "== End of Job =="