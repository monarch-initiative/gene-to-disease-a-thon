
# target to download https://search.thegencc.org/download/action/submissions-export-tsv as gencc.tsv and write into data/ directory using curl

all: download

data:
	mkdir -p data

# Add additional downloads here
download: data/gencc.tsv

data/gencc.tsv: data
	wget -O data/gencc.tsv https://search.thegencc.org/download/action/submissions-export-tsv

 # TODO: add download from exomiser  (?)

 # Create schema
