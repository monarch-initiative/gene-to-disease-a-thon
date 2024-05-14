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
    -- derived from https://github.com/exomiser/Exomiser/blob/ffb2da103ca54a9de03ceecfc70c8ddfcebba3fd/exomiser-core/src/main/java/org/monarchinitiative/exomiser/core/prioritisers/model/InheritanceMode.java#L38
    case
        when moi_code = 'B' then 'exomiser:B' -- autosomal dominant/recessive ?
        when moi_code = 'D' then 'HP:0000006' -- autosomal dominant
        when moi_code = 'M' then 'HP:0001427' -- mitochondrial
        when moi_code = 'P' then 'HP:0010982' -- polygenic
        when moi_code = 'R' then 'HP:0000007' -- autosomal recessive
        when moi_code = 'S' then 'exomiser:S' -- somatic ?
        when moi_code = 'U' then null -- unknown, capture as excplicitly unknown?
        when moi_code = 'X' then 'HP:0001417'
        when moi_code = 'XD' then 'HP:0001423'
        when moi_code = 'XR' then 'HP:0001419'
        when moi_code = 'Y' then 'HP:0001450'
        else null end as moi_id,
    'exomiser' as data_aggregator,
    case when disease_curie like 'OMIM:%' then 'omim'
         when disease_curie like 'ORPHA:%' then 'orphanet'
         else 'unknown' end as original_data_source
from exomiser_disease
left outer join gene_sssom on gene_sssom.object_id = exomiser_disease.mim_gene_curie
left outer join mondo_sssom on mondo_sssom.object_id = exomiser_disease.disease_curie.replace('ORPHA:', 'Orphanet:');





