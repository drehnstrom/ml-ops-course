from setuptools import find_packages, setup

REQUIRED_PACKAGES = ['pandas']

setup(
    name='custom-iris-classifier',
    version='3.0',
    install_requires=REQUIRED_PACKAGES,
    packages=find_packages(),
    description='Training application for a Custom Iris Classifier.'
)
