#! /bin/sh

# Don't forget to add your Project ID and Bucket Name below
export BUCKET=[YOU-BUCKET-NAME]
export REGION=us-central1

# Create a file called pets.txt and then copy it into your Bucket
# This will be the input file for the pipeline
for pet in dog,noir dog,Bree dog,Gigi dog,Gretyl dog,Duchess dog,Rusty cat,Cleo cat,Sparkles cat,Phelix turtle,Cuff turtle,Link
do
  echo $pet >> pets.txt
done

# Create a bucket and copy the input file into it. 
gsutil mb -l $REGION gs://$BUCKET
gsutil cp pets.txt gs://$BUCKET/

# First Create a Python 3 Virtual Environment
# and Activate it. 
python3 -m venv ~/dataflow-venv
source ~/dataflow-venv/bin/activate

# Install Apache Beam. Make sure components are up to date. 
pip install --upgrade setuptools
pip install --upgrade pip
pip install --upgrade wheel
pip install 'apache-beam[gcp]'

python pets-job.py --input gs://$BUCKET/pets.txt \
--output gs://$BUCKET/pets_job_results_out \
--temp_location gs://$BUCKET/tmp/ \
--region us-central1 \
--project $GOOGLE_CLOUD_PROJECT \
--runner DataflowRunner
