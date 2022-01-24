chars=abcdefghijklmnopqrstuvwxyz123456789
bucket_name="dataflow-demo-"
for i in {1..12} ; do
    bucket_name=$bucket_name"${chars:RANDOM%${#chars}:1}" 
done

export BUCKET=$bucket_name
echo "Your random bucket name is: $BUCKET"

