-- this requires the HGNC table and mondo_ssom table

-- Add HGNC
alter table exomiser_disease
    add gene_curie varchar;
alter table exomiser_disease
    add gene_symbol varchar;

update exomiser_disease
set gene_curie  = h.hgnc_id,
    gene_symbol = h.symbol hgnc_complete_set as h
where ncbi_gene_id = h.entrez_id;

-- add MONDO
alter table exomiser_disease
    add mondo_curie varchar;

UPDATE exomiser_disease d
SET mondo_curie = s.subject_id FROM sssom s
WHERE d.disease_curie = s.object_id
  AND d.disease_curie LIKE 'OMIM:%';

UPDATE exomiser_disease d
SET mondo_curie = s.subject_id FROM sssom s
WHERE d.disease_curie = replace(s.object_id, 'Orphanet:', 'ORPHA:')
  AND d.disease_curie LIKE 'ORPHA:%';