insert into gene_to_disease by name
select
     gene_original_curie as original_gene_id,
     gene_curie as hgnc_id,
     disease_original_curie as original_disease_id,
     disease_curie as mondo_id,
     -- as publications  -- these lists require parsing
     moi_curie as moi_id,
     'gencc' as data_aggregator,
     submitter_title as original_data_source
from gencc;


