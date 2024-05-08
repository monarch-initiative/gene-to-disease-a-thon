
# target to download https://search.thegencc.org/download/action/submissions-export-tsv as gencc.tsv and write into data/ directory using curl

DBNAME = output/monarch-g2d.duckdb

all: download load merge

data:
	mkdir -p data

output:
	mkdir -p output

# Add additional downloads here
download: data/gencc.tsv data/mondo.sssom.tsv

data/gencc.tsv: data
	wget -O data/gencc.tsv https://search.thegencc.org/download/action/submissions-export-tsv

data/mondo.sssom.tsv: data
	wget -P data https://data.monarchinitiative.org/mappings/latest/mondo.sssom.tsv

 # TODO: add download from exomiser  (?)
# this is in resources/disease.pg

 # Create schema

load:
	duckdb $(DBNAME) < sql/load.sql

merge: load
	duckdb $(DBNAME) < sql/schema.sql
	duckdb $(DBNAME) < sql/merge.sql
