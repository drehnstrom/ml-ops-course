# Download mpg.csv file
curl -H "Accept: application/vnd.github.VERSION.raw" -O https://api.github.com/repos/drehnstrom/ml-ops-course/contents/./data/iris.csv

# Create BQ dataset and load csv file into table
bq mk iris_dataset
bq load --autodetect iris_dataset.iris ./iris.csv

# See if it worked
bq ls iris_dataset

# Output the first few rows of the table
bq head iris_dataset.iris