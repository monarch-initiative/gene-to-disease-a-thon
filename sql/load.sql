create or replace table gencc as select * from 'data/gencc.tsv';
create or replace table exomiser_disease as select * from read_csv_auto('resources/disease.pg');
create or replace table mondo_sssom as select * from 'data/mondo.sssom.tsv';
create or replace table gene_sssom as select * from 'data/gene_mappings.sssom.tsv';

-- The HGNC and HPOA files are not really required, but are nice to have as a primary source for when doing comparisons
-- create or replace table hgnc_complete_set as select * from 'data/hgnc_complete_set.tsv';
-- create or replace table hpoa as select * from 'data/hpoa.tsv';
