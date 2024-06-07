
# target to download https://search.thegencc.org/download/action/submissions-export-tsv as gencc.tsv and write into data/ directory using curl

DBNAME = output/monarch-g2d.duckdb

all: download load merge

data:
	mkdir -p data

output:
	mkdir -p output

# Add additional downloads here
download: data/gencc.tsv data/mondo.sssom.tsv data/gene_mappings.sssom.tsv

data/gencc.tsv: data
	curl --silent https://search.thegencc.org/download/action/submissions-export-tsv > data/gencc.tsv

data/mondo.sssom.tsv: data
	curl --silent --output-dir data -O https://data.monarchinitiative.org/mappings/latest/mondo.sssom.tsv

data/gene_mappings.sssom.tsv: data
	curl --silent --output-dir data -O https://data.monarchinitiative.org/mappings/latest/gene_mappings.sssom.tsv

# The HGNC and HPOA files are not really required, but are nice to have as a primary source for when doing comparisons
data/hgnc_complete_set.tsv: data
	curl --silent https://g-a8b222.dd271.03c0.data.globus.org/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt > data/hgnc_complete_set.tsv

data/hpoa.tsv: data
	curl --silent -L --max-redirs 10 https://purl.obolibrary.org/obo/hp/hpoa/phenotype.hpoa > data/hpoa.tsv

 # TODO: add download from exomiser  (?)
# this is in resources/disease.pg

 # Create schema

load:
	duckdb $(DBNAME) < sql/load.sql

merge: load
	duckdb $(DBNAME) < sql/schema.sql
	duckdb $(DBNAME) < sql/merge.sql
