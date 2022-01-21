import logging
import os
import tensorflow as tf
import pandas as pd

if 'AIP_MODEL_DIR' not in os.environ:
    raise KeyError(
        'The `AIP_MODEL_DIR` environment variable has not been' +
        'set. See https://cloud.google.com/ai-platform-unified/docs/tutorials/image-recognition-custom/training'
    )

output_directory = os.environ['AIP_MODEL_DIR']

# Get the Dataset
logging.info('Loading and preprocessing data ...')
CSV_COLUMN_NAMES = ['SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth', 'Species']
SPECIES = ['Setosa', 'Versicolor', 'Virginica']


train_path = tf.keras.utils.get_file(
    "iris_training.csv", "https://storage.googleapis.com/download.tensorflow.org/data/iris_training.csv")
test_path = tf.keras.utils.get_file(
    "iris_test.csv", "https://storage.googleapis.com/download.tensorflow.org/data/iris_test.csv")

train_dataset = pd.read_csv(train_path, names=CSV_COLUMN_NAMES, header=0)
test_dataset = pd.read_csv(test_path, names=CSV_COLUMN_NAMES, header=0)

train_features = train_dataset.copy()
test_features = test_dataset.copy()

train_labels = train_features.pop('Species')
test_labels = test_features.pop('Species')

# Build the Model
logging.info('Creating and training model ...')
model = tf.keras.Sequential([
   tf.keras.layers.Dense(8, input_dim=4, activation='linear'),
   tf.keras.layers.Dense(3, activation='softmax'),
])

model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(),
              metrics=['accuracy'])

# Tain the model
model.fit(train_features, 
          train_labels, 
          epochs=100)

# Save the model to Cloud Storage
logging.info(f'Exporting SavedModel to: {output_directory}')
model.save(output_directory)