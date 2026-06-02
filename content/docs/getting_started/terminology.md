---
title: Terminology
weight: 1
next: /docs/getting_started/file_naming_convention
sidebar:
  open: true
draft: false
---

<!-- You know what really grinds my gears? The changing of terminology across space and time. For example, dissemination blocks used to be called blocks-->

## Terms and Definitions

This document provides a standardized lexicon for the **Data for Canada (D4C)** project, categorized by data package and infrastructure component.

<!--
## 1. Foundation Data Package

Terms related to base-layer datasets and structural identifiers.

* **[DGUID (Dissemination Geography Unique Identifier)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo055):** An alphanumeric code used by Statistics Canada to uniquely identify a geographic area. It incorporates the vintage (year), type, and specific area code.
* **[Building Footprint](https://www.dataforcanada.org/docs/d4c-pkgs/d4c-datapkg-foundation/):** The two-dimensional boundary of a building’s ground-level perimeter, primarily sourced from the Open Database of Buildings (ODB).
* **[Cloud-Native Geospatial](https://www.dataforcanada.org/docs/getting_started/):** Data formats (e.g., Parquet, GeoZarr) optimized for cloud storage and efficient partial-file reading over HTTP.
-->

## 1. Statistical Data Package


{{< callout type="important" >}}
  These concepts are key to working with Statistical and Census data from Statistics Canada.
{{< /callout >}}

{{% details title="PDFs" closed="true" %}}
All Statistics Canada terminology is derived from:
- [2021 Census of Population Dictionary](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777398477.100686/www12.statcan.gc.ca/census-recensement/2021/ref/dict/98-301-x2021001-eng.pdf)
{{% /details %}}

Standard geographic areas from the 2021 Census of Population hierarchy, as defined by Statistics Canada.
![geographic hierarchy](geographic-hiearchy.webp)

* **[DGUID (Dissemination Geography Unique Identifier)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777397949.903216/singlefile.html):** An alphanumeric code used by Statistics Canada to uniquely identify a geographic area. It incorporates the vintage (year), type, and specific area code.

### Administrative Areas

<!-- TODO: Add images for each of these concepts, ideally using https://imfing.github.io/hextra/docs/guide/shortcodes/cards/>

<!-- Use pics from the illustrated glossary, but definitions from the 2021 Census of Population-->
<!--https://www150.statcan.gc.ca/n1/pub/92-195-x/92-195-x2021001-eng.htm-->
<!--https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/index-eng.cfm-->
<!-- Have not been able to find a definition in the 2021 Census Dictionary for country -->
<!-- Add image from illustrated glossary https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/prov/prov-eng.htm -->
* **Canada:** The highest level of geography, covering the entire country.
* **[Geographical Region of Canada](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777398847.103377/singlefile.html):** The geographical regions of Canada are groupings of provinces and territories established for the purpose of statistical reporting. The six geographical regions of Canada are:
  - Atlantic
  - Quebec
  - Ontario
  - Prairies
  - British Columbia
  - Territories 

{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777398919.657975/www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/region/region-eng.htm" title="Geographical Region of Canada" image="/docs/getting_started/reg2-eng.png" >}}
{{< /cards >}}

* **[Province or Territory (PR)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777397967.628878/singlefile.html):** "Province" and "territory" refer to the major political units of Canada. Canada is divided into 10 provinces and 3 territories. From a statistical point of view, province and territory are basic areas for which data are tabulated.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777397992.435798/singlefile.html" title="Province or Territory (PR)" image="/docs/getting_started/prov2-eng.png" >}}
{{< /cards >}}
* **[Census Division (CD)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777398160.097593/singlefile.html):** A group of neighboring municipalities joined together for the purposes of regional planning and managing common services.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777398210.970027/singlefile.html" title="Census Division (CD)" image="/docs/getting_started/cd-dr2-eng.png" >}}
{{< /cards >}}
* **[Census Consolidate Subdivision (CCS)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399545.203302/singlefile.html):** A census consolidated subdivision (CCS) is a group of adjacent census subdivisions within the same census division. Generally, the smaller, more densely-populated census subdivisions (towns, villages, etc.) are combined with the surrounding, larger, more rural census subdivision, in order to create a geographic level between the census subdivision and the census division.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399560.613465/www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/ccs-sru/ccs-sru-eng.htm" title="Census Consolidated Subdivision (CCS)" image="/docs/getting_started/ccs-sru2-eng.png" >}}
{{< /cards >}}
* **[Census Subdivision (CSD)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399109.047544/singlefile.html):** The general term for municipalities or areas treated as municipal equivalents for statistical purposes.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399125.074665/www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/csd-sdr/csd-sdr-eng.htm" title="Census Subdivision (CSD)" image="/docs/getting_started/csd-sdr2-eng.png" >}}
{{< /cards >}}
<!-- Need to work on this definition, not technically correct-->
* **[Federal Electoral District (FED)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399693.073865/singlefile.html):** A federal electoral district (FED) is an area represented by a member of the House of Commons. The federal electoral district boundaries used for the 2021 Census are based on the 2013 Representation Order.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399706.715732/singlefile.html" title="Federal Electoral District (FED)" image="/docs/getting_started/fed-cef2.png" >}}
{{< /cards >}}
<!-- TODO: Geographic regions of Canada (GRC). StatCan does not technically provide boundaries, had to create them myself. Add definition, maybe a link to where people can send their feedback on not having official GRC boundaries-->

### Statistical Areas

* **[Economic Region (ER)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399802.964934/singlefile.html):** An economic region (ER) is a grouping of complete census divisions (CDs), with one exception in Ontario, created as a standard geographic unit for analysis of regional economic activity.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399821.651869/singlefile.html" title="Economic Region (ER)" image="/docs/getting_started/er-re.jpg" >}}
{{< /cards >}}
* **[Census Agricultural Region (CAR)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo006):** Census agricultural regions (CARs) are composed of groups of adjacent census divisions.
{{< cards >}}
  {{< card link="https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo006" title="Census Agricultural Region (CAR)" image="/docs/getting_started/car-rar2-eng.jpg" >}}
{{< /cards >}}
* **[Population Centre (POPCTR)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399842.515773/singlefile.html):** A population centre (POPCTR) has a population of at least 1,000 and a population density of 400 persons or more per square kilometre, based on population counts from the current Census of Population. All areas outside population centres are classified as rural areas. Taken together, population centres and rural areas cover all of Canada.
Population centres are classified into three groups, depending on the size of their population:
  * small population centres, with a population between 1,000 and 29,999
  * medium population centres, with a population between 30,000 and 99,999
  * large urban population centres, with a population of 100,000 or more.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399878.502311/singlefile.html" title="Population Centre (POPCTR)" image="/docs/getting_started/pop-ctr-eng.png" >}}
{{< /cards >}}
* **[Census Metropolitan Area (CMA)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399913.548297/singlefile.html):** A census metropolitan area (CMA) or a census agglomeration (CA) is formed by one or more adjacent municipalities centred on a population centre (known as the core). A CMA must have a total population of at least 100,000 based on data from the current Census of Population Program, of which 50,000 or more must live in the core based on adjusted data from the previous Census of Population Program. To be included in the CMA or CA, other adjacent municipalities must have a high degree of integration with the core, as measured by commuting flows derived from data on place of work from the previous Census Program.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399913.548297/singlefile.html" title="Census Metropolitan Area (CMA)" image="/docs/getting_started/cma-rmr.png" >}}
{{< /cards >}}
* **[Census Agglomeration (CA)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399913.548297/singlefile.html):** Similar to a CMA, but with a core population of at least 10,000. To be included in the CMA or CA, other adjacent municipalities must have a high degree of integration with the core, as measured by commuting flows derived from data on place of work from the previous Census Program.
* **[Census Tract (CT)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399954.202141/singlefile.html):** Census tracts (CTs) are small, relatively stable geographic areas that usually have a population of fewer than 7,500 persons, based on data from the previous Census of Population Program. They are located in census metropolitan areas (CMAs) and in census agglomerations (CAs) that had a core population of 50,000 or more in the previous census.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399970.429995/singlefile.html" title="Census Tract (CT)" image="/docs/getting_started/ct-sr_02-eng.png" >}}
{{< /cards >}}

* **[Aggregate Dissemination Area (ADA)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777399988.113599/singlefile.html):** An aggregate dissemination area (ADA) is a dissemination geography created for the Census. ADAs cover the entire country and, where possible, have a population between 5,000 and 15,000 based on the previous census population counts. ADAs are created by grouping existing dissemination geographic areas, including census tracts (CTs), census subdivisions (CSDs) or dissemination areas (DAs). ADA boundaries respect provincial, territorial, census division (CD), census metropolitan area (CMA) and census agglomeration (CA) boundaries.
* **[Dissemination Area (DA)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777400015.923444/singlefile.html):** A dissemination area (DA) is a small, relatively stable geographic unit composed of one or more adjacent dissemination blocks with an average population of 400 to 700 persons based on data from the previous Census of Population Program. It is the smallest standard geographic area for which all census data are disseminated. DAs cover all the territory of Canada.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777400032.249898/singlefile.html" title="Dissemination Area (DA)" image="/docs/getting_started/da-ad2.png" >}}
{{< /cards >}}
* **[Dissemination Block (DB)](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777400122.59715/singlefile.html):** A dissemination block (DB) is an area bounded on all sides by roads and/or boundaries of Statistics Canada’s standard geographic areas for dissemination. The dissemination block is the smallest geographic area for which population and dwelling counts are disseminated. Dissemination blocks cover all the territory of Canada.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777400134.69831/singlefile.html" title="Dissemination Block (DB)" image="/docs/getting_started/db-id2.png" >}}
{{< /cards >}}
* **[Blockface](https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777400245.709323/singlefile.html):** A blockface represents one side of a street between two consecutive features intersecting that street. The features can be other streets or boundaries of standard geographic areas. Blockfaces are used for generating blockface representative points, which in turn are used for geocoding and census data extraction when the street and address information are available.
{{< cards >}}
  {{< card link="https://s3.dataforcanada.org/tigris/d4u-datapkg-web-corpus/archive/1777400229.760594/www150.statcan.gc.ca/n1/pub/92-195-x/2021001/other-autre/bf-ci/bf-ci-eng.htm" title="Blockface" image="/docs/getting_started/bf-ci2.png" >}}
{{< /cards >}}

<!-- Gemini can sometimes be...unsmart>
<!--* **[Rural Area](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo042):** All territory lying outside population centres.-->

## 3. Orthoimagery & Field Imagery Packages

Terms related to imagery processing and remote sensing.

* **[Orthoimagery](https://www.dataforcanada.org/docs/d4c-pkgs/d4c-datapkg-orthoimagery/):** Aerial or satellite imagery geometrically corrected ("orthorectified") such that the scale is uniform, allowing for accurate measurements of distance.
* **[Photogrammetry](https://www.dataforcanada.org/docs/d4c-pkgs/d4c-datapkg-field-imagery/):** The science of making measurements from photographs, used to generate 3D models and orthomosaics.
