---
title: Census Data
weight: 2
#next: /docs/d4c-datapkg-orthoimagery/
---

Look through our [d4c-datapkg-statistical](https://github.com/dataforcanada/d4c-datapkg-statistical) repo for the datasets processed.

## Background

{{< callout type="important" >}}
  The concepts listed in [terms](/docs/getting_started/terminology/#1-statistical-data-package) are key to working with Statistical and Census data from Statistics Canada.
{{< /callout >}}

## Download and Preview

You can download the raw **Parquet** files directly or use the **Map Preview** links to inspect the data as vector tiles.

{{< details title="Instructions" closed="true" >}}

### How to use the Map Preview

The map preview allows you to visualize specific census characteristics dynamically. Follow this workflow to verify the data before downloading.

**1. Identify your Characteristic ID**
Census variables are mapped using numeric IDs. Consult the **[Characteristic ID Reference Sheet](https://1drv.ms/x/c/d42308bcd3b7a4a1/ESlrAmKqXp9BnsMXqurcB0sB9qy1r2-ZV8tCL9nCns_Mpg?e=8qIroJ)** to find the ID for the data you want to view.

* *Example:* The ID for "Number of COVID-19 emergency and recovery benefits recipients..." is **124**.

**2. Open the Preview**
Click the link in the **Dataset ID & Preview** column for your desired geographic level (e.g., Provinces, Federal Electoral Districts).

**3. Filter by Attribute**
In the top-right "Search fields" box, enter the attribute key using the format `{gender}_{ID}`:

* **Total:** Enter `total_124`
* **Male:** Enter `men_124`
* **Female:** Enter `women_124`

**4. Update the Map**
Click the **"Recalculate Classes"** button. This will refresh the map legend and choropleth coloring based on the currently visible extent.
{{< /details >}}

{{< callout type="info">}}
**Note on Data Availability:** Dissemination blocks currently only contain these **[3 specific characteristics](https://github.com/dataforcanada/d4c-datapkg-statistical/issues/6)**.
{{< /callout >}}

{{< callout type="note">}}
**Credit:**

* The location search functionality in our map previews is powered by the **[PHAC Geocoder](https://geocoder.alpha.phac.gc.ca/)**.
* The basemaps is generously served through [OpenFreeMap](https://openfreemap.org/).
{{< /callout >}}

| Place  | ISO | Date | Provider | Dataset ID & Preview                                                                                                                                                                                                          | Parquet                                                                                                                                                                                                                     |
| ------ | --- | ---- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_provinces_territories_2021_v0.1.0-beta                                                                                                                           | Coming Soon                                 |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_federal_electoral_districts_2013_representation_order_2021_v0.1.0-beta                                                                                           | Coming Soon |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_federal_electoral_districts_2023_representation_order_2021_v0.1.0-beta                                                                                           | Coming Soon |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_economic_regions_2021_v0.1.0-beta                                                                                                                                | Coming Soon                                      |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_census_metropolitan_areas_and_census_agglomerations_2021_v0.1.0-beta                                                                                             | Coming Soon   |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_census_divisions_2021_v0.1.0-beta                                                                                                                                | Coming Soon                                      |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_designated_places_2021_v0.1.0-beta                                                                                                                               | Coming Soon                                     |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_aggregate_dissemination_areas_2021_v0.1.0-beta                                                                                                                   | Coming Soon                         |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_census_subdivisions_2021_v0.1.0-beta                                                                                                                             | Coming Soon                                   |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_population_centres_2021_v0.1.0-beta                                                                                                                              | Coming Soon                                    |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_forward_sortation_areas_2021_v0.1.0-beta                                                                                                                         | Coming Soon                               |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_census_tracts_2021_v0.1.0-beta                                                                                                                                   | Coming Soon                                         |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_dissemination_areas_2021_v0.1.0-beta                                                                                                                             | Coming Soon                                   |
| Canada | CA  | 2021 | StatCan  | ca_statcan_2021A000011124_d4c-datapkg-statistical_census_pop_dissemination_blocks_2021_v0.1.0-beta                                                                                                                            | Coming Soon                                  |