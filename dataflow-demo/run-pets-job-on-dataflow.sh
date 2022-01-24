#! /bin/sh
export REGION=us-central

python pets-job.py --input gs://$BUCKET/pets.txt \
--output gs://$BUCKET/pets_job_results_out \
--temp_location gs://$BUCKET/tmp/ \
--region $REGION \
--project $GOOGLE_CLOUD_PROJECT \
--runner DataflowRunner
