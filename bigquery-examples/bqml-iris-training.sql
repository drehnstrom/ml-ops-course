-- ********************************************
-- SQL to Train the Model
CREATE OR REPLACE MODEL `iris_dataset.iris_model`
OPTIONS(model_type='logistic_reg', 
        DATA_SPLIT_METHOD='RANDOM', 
        MAX_ITERATIONS=20) AS
SELECT
  species as label,
  sepal_length,sepal_width,
  petal_length,petal_width
FROM
  `iris_dataset.iris`;


-- ********************************************
  -- SQL to Evaluate the Model
SELECT
  *
FROM
  ML.EVALUATE(MODEL `iris_dataset.iris_model`);


-- ********************************************
-- SQL for Confusion Matrix
SELECT
  *
FROM
  ML.CONFUSION_MATRIX(MODEL `iris_dataset.iris_model`);


-- ********************************************
-- SQL to Predict with the Model
SELECT
  *
FROM
  ML.PREDICT(MODEL `iris_dataset.iris_model`,
    (
    SELECT 5.2 AS sepal_length, 3.0 AS sepal_width,
           2.25 AS petal_length,3.3 AS petal_width ));

-- ********************************************
-- SQL to Train the DNN Model
CREATE OR REPLACE MODEL `iris_dataset.iris_dnn_model`
OPTIONS(model_type='dnn_classifier', 
        DATA_SPLIT_METHOD='RANDOM', 
        MAX_ITERATIONS=20,
        HIDDEN_UNITS=[12, 6, 3],
        ACTIVATION_FN='relu') AS
SELECT
  species as label,
  sepal_length,sepal_width,
  petal_length,petal_width
FROM
  `iris_dataset.iris`;
