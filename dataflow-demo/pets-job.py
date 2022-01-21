"""A template to import the default package and parse the arguments"""
from __future__ import absolute_import

import argparse
import logging
import re, os

import apache_beam as beam
from apache_beam.io import ReadFromText
from apache_beam.io import WriteToText
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import SetupOptions

class ParsePets(beam.DoFn):
    def process(self,element):
        species, name = element.split(',')
        yield (species, name)

class NoCats(beam.DoFn):
    def process(self,element):
        if element[0] != 'cat':
          yield element

def run(argv=None, save_main_session=True):
  parser = argparse.ArgumentParser()
  parser.add_argument(
      '--input',
      dest='input',
      help='Input file to process.')
  parser.add_argument(
      '--output',
      dest='output',
      help='Output file to write results to.')
  known_args, pipeline_args = parser.parse_known_args(argv)

  # We use the save_main_session option because one or more DoFn's in this
  # workflow rely on global context (e.g., a module imported at module level).
  pipeline_options = PipelineOptions(pipeline_args)
  pipeline_options.view_as(SetupOptions).save_main_session = save_main_session

  # The pipeline will be run on exiting the with block.
  with beam.Pipeline(options=pipeline_options) as p:
    (
        p | 'Read' >> ReadFromText(known_args.input)
          | 'Parse' >> beam.ParDo(ParsePets())
          | 'Filter' >> beam.ParDo(NoCats())
          | 'PairWIthOne' >> beam.Map(lambda x: (x[0], 1))
          | 'GroupAndSum' >> beam.CombinePerKey(sum)
          | 'Write' >> WriteToText(known_args.output)
    )

if __name__ == '__main__':
  logging.getLogger().setLevel(logging.INFO)
  run()