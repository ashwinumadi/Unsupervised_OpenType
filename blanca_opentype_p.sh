#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=24:00:00
#SBATCH --partition=blanca-curc-gpu
#SBATCH --gres=gpu:1
#SBATCH --output=Crowd_test_bin2-%j.out
#SBATCH --mail-type="ALL"
#SBATCH --mail-user="asum8093@colorado.edu"

module purge

module load anaconda
module load cuda/12.1.1
#cd /rc_scratch/asum8093/open_type/resources/
#wget http://nlp.stanford.edu/data/glove.840B.300d.zip
#unzip glove.840B.300d.zip -d ./

#wget http://nlp.cs.washington.edu/entity_type/data/ultrafine_acl18.tar.gz

#tar -xvzf ultrafine_acl18.tar.gz

#cd ../




cd /rc_scratch/asum8093/open_type_pp/

#wget http://nlp.cs.washington.edu/entity_type/data/ultrafine_acl18.tar.gz

#tar -xvzf ultrafine_acl18.tar.gz

#mkdir open_type
#mv release/ ./open_type

mv ./bin_1.json ../open_type/release/crowd/
mv ./bin_2.json ../open_type/release/crowd/
mv ./bin_3.json ../open_type/release/crowd/
mv ./bin_4.json ../open_type/release/crowd/

conda activate py38-pt1131-cuda117

pip install stanza
pip install sentence-transformers
pip install inflect
echo "-----------------"
pwd

#cd ./Unsupervised_OpenType/

#mkdir predictions_jobimtext

echo "====== Running The Model ========"

bash scripts/open_type_et_with_jobimtext.sh

cd ../open_type/
git clone https://github.com/uwnlp/open_type.git

cd ./open_type
python scorer.py ../../Unsupervised_OpenType/predictions_jobimtext/predictions_open_type_with_jobimtext

echo "== End of Job =="