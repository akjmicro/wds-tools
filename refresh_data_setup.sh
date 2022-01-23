#!/bin/sh

########################################
# Fetch the raw, fixed-with text files #
########################################
curl http://www.astro.gsu.edu/wds/misc/wds.summ_con.txt > raw_data/wds_summ_con.txt
# `tail -n +5` pie section is here b/c the file has some garbage at the top.
# If this format should change, it will break a few entries in the resulting CSV.
curl http://www.astro.gsu.edu/wds/misc/bf.txt | tail -n +5 > raw_data/wds_bf_xref.txt

######################################################################
# The purpose here is to extract the fixed width text files that the #
# WDS distributes into CSVs (really, pipe-delimited values)          #
######################################################################
cat raw_data/wds_summ_con.txt \
  | cut -b 1-10,29-32,43-45,53-57,59-63,65-69,71-79,113-130,133-135 \
        --output-delimiter '|' \
  | sed -r -e 's/ {2,}/ /g; s/ \|/\|/g; s/\| /\|/g' \
  > raw_data/doubles.csv

cat raw_data/wds_bf_xref.txt \
  | cut -b 1-10,12-21,23-44,45-66,67-88,89-114 --output-delimiter '|' \
  | sed -r -e 's/([A-Z])([0-9])/\1 \2/g; s/ {2,}/ /g; s/ \|/\|/g; s/\| /\|/g; s/\.//g' \
  > raw_data/doubles_xref.csv

# Finally, import the data into the database:
sqlite3 wds_doubles.db < dbsetup.sql
