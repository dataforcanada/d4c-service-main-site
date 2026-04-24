-- Load Extensions
INSTALL httpfs;
LOAD httpfs;
INSTALL spatial;
LOAD spatial;

-- Verbosity & Performance Monitoring
SET enable_progress_bar=true;
--PRAGMA enable_profiling='query_tree';
--SET explain_output='all';
SET enable_progress_bar=true;
--PRAGMA enable_profiling='json'; -- or 'query_tree' for a visual text tree
SET http_keep_alive=true;

SET s3_region = 'us-west-2';
SET s3_endpoint = 's3.us-west-2.amazonaws.com';
SET s3_url_style = 'vhost';
SET s3_use_ssl = false;

SET http_timeout = 60000;
SET http_retries = 5;
SET http_retry_backoff = 2.0;
SET http_keep_alive = true;
SET enable_http_metadata_cache = true;
SET enable_object_cache = true;

/*
2021 Provinces and Territories, Digital Boundaries. 
count_total_24 = "Total - 65 years and over"
count_men_24 = "Male - 65 years and over"
count_female_24 = "Female - 65 years and over"
*/
SELECT DISTINCT
    geo.*, cop.count_total_24, cop.count_men_24, cop.count_women_24
FROM 
    read_parquet('s3://us-west-2.opendata.source.coop/dataforcanada/d4c-datapkg-statistical/processed/ca_statcan_2021A000011124_d4c-datapkg-statistical_provinces_territories_digital_2021_v0.1.0-beta.parquet') as geo,
    read_parquet('s3://us-west-2.opendata.source.coop/dataforcanada/d4c-datapkg-statistical/processed/ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_provinces_territories_2021_v0.1.0-beta.parquet') as cop
WHERE cop.pr_dguid = geo.pr_dguid;

/*
2021 Provinces and Territories, Cartographic Boundaries.
count_total_24 = "Total - 65 years and over"
count_men_24 = "Male - 65 years and over"
count_female_24 = "Female - 65 years and over"
*/