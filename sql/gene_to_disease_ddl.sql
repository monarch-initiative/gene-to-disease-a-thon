create or replace table gene_to_disease
(
    original_gene_id varchar not null,
    hgnc_gene_id varchar,

    -- something that represents the relationship between the gene and disease?

    original_disease_id varchar not null,
    mondo_disease_id varchar,

    --something to represent the strength of evidence? (classification curie from gencc)
    publications varchar[],
    mode_of_inheritance varchar,

);