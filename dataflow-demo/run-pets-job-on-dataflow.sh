#! /bin/sh

# Don't forget to add your Project ID and Bucket Name below
export PROJECT=[YOUR-PROJECT_ID]
export BUCKET=[YOU-BUCKET-NAME]
export REGION=us-central1

python pets-job.py --input gs://$BUCKET/pets.txt \
--output gs://$BUCKET/pets_job_results_out \
--temp_location gs://$BUCKET/tmp/ \
--region us-central1 \
--project $PROJECT \
--runner DataflowRunner