insert into gene_to_disease by name
select
     gene_curie as original_gene_id,
     gene_curie as hgnc_id,
     disease_original_curie as original_disease_id,
     disease_curie as mondo_id,
     -- as publications  -- these lists require parsing
     moi_curie as moi_id,
     'gencc' as data_aggregator,
     submitter_title as original_data_source
from gencc;

insert into gene_to_disease by name
select
    mim_gene_curie as original_gene_id,
    gene_sssom.subject_id as hgnc_id,
    disease_curie as original_disease_id,
    mondo_sssom.subject_id as mondo_id,
    moi_code as moi_id,
    'exomiser' as data_aggregator,
    case when disease_curie like 'OMIM:%' then 'omim'
         when disease_curie like 'ORPHA:%' then 'orphanet'
         else 'unknown' end as original_data_source
from exomiser_disease
left outer join gene_sssom on gene_sssom.object_id = exomiser_disease.mim_gene_curie
left outer join mondo_sssom on mondo_sssom.object_id = exomiser_disease.disease_curie.replace('ORPHA:', 'Orphanet:');





