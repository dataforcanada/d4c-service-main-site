---
title: Added 2021 Census of Agriculture Data
summary: 
date: 2026-06-02T14:00:00-04:00
authors:
  - name: diegoripley
    link: https://github.com/diegoripley
    image: https://github.com/diegoripley.png
tags:
  - census-of-agriculture
  - ceag
excludeSearch: false
draft: true
---

We have added processed 2021 Census of Agriculture data Zenodo, Source Cooperative, and the Internet Archive, just click on the download button in the table below.

| Place  | ISO | Date | Provider | Dataset ID                                                                                                                                                                                                          | Download |
| ------ | --- | ---- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_ag_country_2021_v0.1.0-beta | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20085959.svg)](https://doi.org/10.5281/zenodo.20085959) |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_ag_provinces_territories_2021_v0.1.0-beta | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20085916.svg)](https://doi.org/10.5281/zenodo.20085916) |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_ag_census_agricultural_regions_2021_v0.1.0-beta | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20086698.svg)](https://doi.org/10.5281/zenodo.20086698) |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_ag_census_divisions_2021_v0.1.0-beta | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20086330.svg)](https://doi.org/10.5281/zenodo.20086330) |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_ag_census_consolidated_subdivisions_2021_v0.1.0-beta | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20086117.svg)](https://doi.org/10.5281/zenodo.20086117) |

## Simple Example
Similarly to the Census of Population data, we will need to use a [spreadsheet](https://1drv.ms/x/c/d42308bcd3b7a4a1/IQBlXJTQZzbQTbCq7_7h1AD7AS5pkEaXbsaVqXiGDnDz_H8?e=1rgstP) to determine what variables to extract. Let's say we are interested in finding out the counts of farm operators by age ranges 

| 2021 Variables | Categories     | 2021 Long description of the variables (EN)       | 2021 Description longue des variables (FR)             |
|----------------|----------------|---------------------------------------------------|--------------------------------------------------------|
| ageund35_n     | Farm operators | Age: Under 35 years - Number of farm operators    | Âge : Moins de 35 ans - Nombre d'exploitants agricoles |
| age3554        | Farm operators | Age: 35 to 54 years - Number of farm operators    | Âge : 35 à 54 ans - Nombre d'exploitants agricoles     |
| ageov55_n      | Farm operators | Age: 55 years and over - Number of farm operators | Âge : 55 ans et plus - Nombre d'exploitants agricoles  |

```sql
SELECT
    ceag.pr_dguid,
    ceag.ageund35_n,
    ceag.age3554,
    ceag.ageov55_n,
    geo.geom
FROM
    'https://data.source.coop/dataforcanada/d4c-datapkg-statistical/processed/ca_statcan_2021A000011124_d4c-datapkg-statistical_census_ag_provinces_territories_2021_v0.1.0-beta.parquet' AS ceag,
    'https://data.source.coop/dataforcanada/d4c-datapkg-statistical/processed/ca_statcan_2021A000011124_d4c-datapkg-statistical_provinces_territories_cartographic_2021_v0.1.0-beta.parquet' AS geo
WHERE ceag.pr_dguid = geo.pr_dguid;
```