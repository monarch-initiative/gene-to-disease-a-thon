create or replace table gene_to_disease
(
    original_gene_id varchar not null,
    hgnc_id varchar,

    -- something that represents the relationship between the gene and disease?

    original_disease_id varchar not null,
    mondo_id varchar,

    --something to represent the strength of evidence? (classification curie from gencc)
    publications varchar[],
    moi_id varchar,
    data_aggregator varchar, -- gencc, exomiser, etc
    original_data_source varchar, -- omim, orphanet, decipher, panelapp uk, etc
);