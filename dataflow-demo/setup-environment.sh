# Generate a Random name for a Cloud Storage Bucket
chars=abcdefghijklmnopqrstuvwxyz123456789
bucket_name="dataflow-demo-"
for i in {1..12} ; do
    bucket_name=$bucket_name"${chars:RANDOM%${#chars}:1}" 
done

export BUCKET=$bucket_name
echo "Your random bucket name is: $BUCKET"

# Create the Bucket
gsutil mb -l us-central1 gs://$BUCKET

# Generate a test input file
for pet in dog,noir dog,Bree dog,Gigi dog,Gretyl dog,Duchess dog,Rusty cat,Cleo cat,Sparkles cat,Phelix turtle,Cuff turtle,Link
do
  echo $pet >> ./pets.txt
done

# Copy the test file into the bucket
gsutil cp ./pets.txt gs://$BUCKET/


# Create Python 3 Virtual Environment
python3 -m venv ~/dataflow-venv
source ~/dataflow-venv/bin/activate

# Install the Requirements
pip install --upgrade setuptools
pip install --upgrade pip
pip install --upgrade wheel
pip install 'apache-beam[gcp]'
