create or replace table gencc as select * from 'data/gencc.tsv';
create or replace table exomiser_disease as select * from read_csv_auto('resources/disease.pg');
create or replace table mondo_sssom as select * from 'data/mondo.sssom.tsv';
create or replace table gene_sssom as select * from 'data/gene_mappings.sssom.tsv';
