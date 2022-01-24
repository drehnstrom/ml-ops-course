# Download mpg.csv file
curl -H "Accept: application/vnd.github.VERSION.raw" -O https://api.github.com/repos/drehnstrom/ml-ops-course/contents/./data/mpg.csv

# Create BQ dataset and load csv file into table
bq mk mpg_dataset
bq load --autodetect mpg_dataset.mpg_raw ./mpg.csv

# See if it worked
bq ls mpg_dataset

# Output the first few rows of the table
bq head mpg_dataset.mpg_raw