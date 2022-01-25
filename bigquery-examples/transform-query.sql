CREATE OR REPLACE TABLE mpg_dataset.mpg_transformed
AS(
SELECT
  MPG, Cylinders, Displacement, Horsepower,
  Weight, Acceleration, Model_Year,
  if( Origin = 1, 1, 0) AS USA,
  if( Origin = 2, 1, 0) AS Europe,
  if( Origin = 3, 1, 0) AS Japan
FROM
  `mpg_dataset.mpg_raw`
WHERE
  Horsepower IS NOT NULL);