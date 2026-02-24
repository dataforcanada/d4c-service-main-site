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

Standard geographic areas from the 2021 Census of Population hierarchy, as defined by Statistics Canada.

{{< callout type="important" >}}
  These concepts are key to working with Statistical and Census data from Statistics Canada.
{{< /callout >}}

* **[DGUID (Dissemination Geography Unique Identifier)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo055):** An alphanumeric code used by Statistics Canada to uniquely identify a geographic area. It incorporates the vintage (year), type, and specific area code.

![geographic hierarchy](geographic-hiearchy.webp)

### Administrative Areas

<!-- TODO: Add images for each of these concepts, ideally using https://imfing.github.io/hextra/docs/guide/shortcodes/cards/>

<!-- Use pics from the illustrated glossary, but definitions from the 2021 Census of Population-->
<!--https://www150.statcan.gc.ca/n1/pub/92-195-x/92-195-x2021001-eng.htm-->
<!--https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/index-eng.cfm-->
<!-- Have not been able to find a definition in the 2021 Census Dictionary for country -->
<!-- Add image from illustrated glossary https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/prov/prov-eng.htm -->
* **Canada:** The highest level of geography, covering the entire country.
* **[Province or Territory (PR)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo038):** "Province" and "territory" refer to the major political units of Canada. Canada is divided into 10 provinces and 3 territories. From a statistical point of view, province and territory are basic areas for which data are tabulated.
{{< cards >}}
  {{< card title="Province or Territory (PR)" image="/docs/getting_started/prov2-eng.png" >}}
{{< /cards >}}
* **[Census Division (CD)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo008):** A group of neighboring municipalities joined together for the purposes of regional planning and managing common services.
{{< cards >}}
  {{< card title="Census Division (CD)" image="/docs/getting_started/cd-dr2-eng.png" >}}
{{< /cards >}}
* **[Census Subdivision (CSD)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo012):** The general term for municipalities or areas treated as municipal equivalents for statistical purposes.
{{< cards >}}
  {{< card title="Census Subdivision (CSD)" image="/docs/getting_started/csd-sdr2-eng.png" >}}
{{< /cards >}}
<!-- Need to work on this definition, not technically correct-->
* **[Federal Electoral District (FED)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo025):** A federal electoral district (FED) is an area represented by a member of the House of Commons. The federal electoral district boundaries used for the 2021 Census are based on the 2013 Representation Order.
{{< cards >}}
  {{< card title="Federal Electoral District (FED)" image="/docs/getting_started/fed-cef2.png" >}}
{{< /cards >}}
<!-- TODO: Geographic regions of Canada (GRC). StatCan does not technically provide boundaries, had to create them myself. Add definition, maybe a link to where people can send their feedback on not having official GRC boundaries-->

### Statistical Areas

* **[Aggregate Dissemination Area (ADA)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo053):** An aggregate dissemination area (ADA) is a dissemination geography created for the Census. ADAs cover the entire country and, where possible, have a population between 5,000 and 15,000 based on the previous census population counts. ADAs are created by grouping existing dissemination geographic areas, including census tracts (CTs), census subdivisions (CSDs) or dissemination areas (DAs). ADA boundaries respect provincial, territorial, census division (CD), census metropolitan area (CMA) and census agglomeration (CA) boundaries.
* **[Census Metropolitan Area (CMA)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo009):** A census metropolitan area (CMA) or a census agglomeration (CA) is formed by one or more adjacent municipalities centred on a population centre (known as the core). A CMA must have a total population of at least 100,000 based on data from the current Census of Population Program, of which 50,000 or more must live in the core based on adjusted data from the previous Census of Population Program. To be included in the CMA or CA, other adjacent municipalities must have a high degree of integration with the core, as measured by commuting flows derived from data on place of work from the previous Census Program.
{{< cards >}}
  {{< card title="Census Metropolitan Area (CMA)" image="/docs/getting_started/cma-rmr.png" >}}
{{< /cards >}}
* **[Census Agglomeration (CA)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo009):** Similar to a CMA, but with a core population of at least 10,000. To be included in the CMA or CA, other adjacent municipalities must have a high degree of integration with the core, as measured by commuting flows derived from data on place of work from the previous Census Program.
* **[Census Tract (CT)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo013):** Census tracts (CTs) are small, relatively stable geographic areas that usually have a population of fewer than 7,500 persons, based on data from the previous Census of Population Program. They are located in census metropolitan areas (CMAs) and in census agglomerations (CAs) that had a core population of 50,000 or more in the previous census.
{{< cards >}}
  {{< card title="Census Tract (CT)" image="/docs/getting_started/ct-sr_02-eng.png" >}}
{{< /cards >}}
* **[Dissemination Area (DA)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo021):** A dissemination area (DA) is a small, relatively stable geographic unit composed of one or more adjacent dissemination blocks with an average population of 400 to 700 persons based on data from the previous Census of Population Program. It is the smallest standard geographic area for which all census data are disseminated. DAs cover all the territory of Canada.
{{< cards >}}
  {{< card title="Census Tract (CT)" image="/docs/getting_started/da-ad2.png" >}}
{{< /cards >}}
* **[Dissemination Block (DB)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo022):** A dissemination block (DB) is an area bounded on all sides by roads and/or boundaries of Statistics Canada’s standard geographic areas for dissemination. The dissemination block is the smallest geographic area for which population and dwelling counts are disseminated. Dissemination blocks cover all the territory of Canada.
{{< cards >}}
  {{< card title="Dissemination Block (DB)" image="/docs/getting_started/db-id2.png" >}}
{{< /cards >}}
* **[Economic Region (ER)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo022):** An economic region (ER) is a grouping of complete census divisions (CDs), with one exception in Ontario, created as a standard geographic unit for analysis of regional economic activity.
{{< cards >}}
  {{< card title="Economic Region (ER)" image="/docs/getting_started/er-re.jpg" >}}
{{< /cards >}}
* **[Population Centre (POPCTR)](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo049a):** A population centre (POPCTR) has a population of at least 1,000 and a population density of 400 persons or more per square kilometre, based on population counts from the current Census of Population. All areas outside population centres are classified as rural areas. Taken together, population centres and rural areas cover all of Canada.
Population centres are classified into three groups, depending on the size of their population:
  * small population centres, with a population between 1,000 and 29,999
  * medium population centres, with a population between 30,000 and 99,999
  * large urban population centres, with a population of 100,000 or more.
{{< cards >}}
  {{< card title="Population Centre (POPCTR)" image="/docs/getting_started/pop-ctr-eng.png" >}}
{{< /cards >}}

<!-- Gemini can sometimes be...unsmart>
<!--* **[Rural Area](https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo042):** All territory lying outside population centres.-->

## 3. Orthoimagery & Field Imagery Packages

Terms related to imagery processing and remote sensing.

* **[Orthoimagery](https://www.dataforcanada.org/docs/d4c-pkgs/d4c-datapkg-orthoimagery/):** Aerial or satellite imagery geometrically corrected ("orthorectified") such that the scale is uniform, allowing for accurate measurements of distance.
* **[Photogrammetry](https://www.dataforcanada.org/docs/d4c-pkgs/d4c-datapkg-field-imagery/):** The science of making measurements from photographs, used to generate 3D models and orthomosaics.

<!--
## 4. Infrastructure & Distribution

Terms related to the decentralized delivery of D4C data.

* **[Source Cooperative](https://www.dataforcanada.org/infrastructure/):** A cloud-native data publishing utility where D4C hosts primary repositories.
* **[SpatioTemporal Asset Catalogs (STAC)](https://www.dataforcanada.org/docs/d4c-infra-distribution/):** A specification that provides a common language to describe geospatial datasets so they can more easily be indexed and discovered.
-->
