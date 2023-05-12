#! /bin/bash

# Setup Training Data
pip install -r requirements.txt

cd datasets
unzip archive.zip
mkdir -p ./custom/images/plates/
mkdir -p ./custom/labels/plates/
python3 ../src/script.py
rm -rf Indian_eu_br_us_plates_compressed/
rm indian_eu_br_us.csv

