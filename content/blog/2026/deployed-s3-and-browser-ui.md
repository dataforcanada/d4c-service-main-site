---
title: Deployed S3 Interface and S3 Browser UI
summary: Making open data more accessible through our new S3-compatible endpoint and an intuitive web-based object explorer.
date: 2026-05-03T14:30:00-04:00
authors:
  - name: diegoripley
    link: https://github.com/diegoripley
    image: https://github.com/diegoripley.png
tags:
  - s3
  - infrastructure
excludeSearch: false
---

A core part of the mission here at Data for Canada is modernizing how we access, store, and interact with public datasets. Today, we are excited to announce a step forward in our infrastructure with the deployment of a new S3-compatible API and a companion web-based explorer.

These two tools are designed to serve both programmatic workflows and everyday discovery.

## 1. The Programmatic S3 Interface
[developmentseed/multistore](https://github.com/developmentseed/multistore/) has been successfully deployed to [https://s3.dataforcanada.org/](https://s3.dataforcanada.org/). This is the exact same technology utilized by the [Source Cooperative read-only data proxy](https://github.com/source-cooperative/data.source.coop). To give you an idea of its proven scalability, this proxy recently served over 1 billion requests and transferred just under 3PB of data in April 2026 alone. (You can read more about these metrics in Jed Sundwall's [recent LinkedIn announcement](https://www.linkedin.com/posts/jedsundwall_source-cooperative-appears-to-have-turned-share-7465709591096360961-uO5P/)).

For data pipelines and cloud-native workflows, standard access protocols are everything. Multistore provides a robust S3-compatible interface, allowing developers, researchers, and data engineers to interact with our hosted datasets using familiar S3 tools and libraries. Whether you are automating data pipelines, querying cloud-optimized formats directly over the network, or syncing large datasets, this endpoint ensures that data retrieval is fast, scalable, and standardized.

```mermaid
flowchart TD
    Client(["🌐 S3 Client / User"])
    Gateway["<b>s3.dataforcanada.org</b>\nS3-Compatible Gateway"]

    Client -->|"S3 API Request"| Gateway

    Gateway -->|"source-cooperative-ca-central-1 bucket"| AWS
    Gateway -->|"backblaze-ca-east-006 bucket"| BB
    Gateway -->|"cloudflare-apac bucket"| CFAPAC
    Gateway -->|"cloudflare-enam bucket"| CFENAM
    Gateway -->|"tigris bucket"| TIGRIS

    subgraph AWS ["☁️ Amazon Web Services"]
        AWSNode["📍 Montreal, QC, Canada"]
    end

    subgraph BB ["🔵 Backblaze B2"]
        BBNode["📍 Toronto, ON, Canada"]
    end

    subgraph CFAPAC ["🟠 Cloudflare R2"]
        CFAPACNode["📍 Asia Pacific Region"]
    end

    subgraph CFENAM ["🟠 Cloudflare R2"]
        CFENAMNode["📍 Eastern North America"]
    end

    subgraph TIGRIS ["⚡ Tigris Data"]
        TIGRISNode["11 Regions Worldwide 🌍\nAuto-routes to nearest location\nfor lowest latency"]
    end

    style Gateway fill:#1a5f7a,color:#fff,stroke:#0d3d52
    style Client fill:#2d6a4f,color:#fff,stroke:#1b4332
    style AWSNode fill:#ff9900,color:#000,stroke:#cc7a00
    style BBNode fill:#e03c31,color:#fff,stroke:#b02d24
    style CFAPACNode fill:#f6821f,color:#fff,stroke:#c4681a
    style CFENAMNode fill:#f6821f,color:#fff,stroke:#c4681a
    style TIGRISNode fill:#6c3483,color:#fff,stroke:#512e6b
```
## 2. The S3 Browser UI
To complement the API, we have also deployed [walkthru-earth/objex](https://github.com/walkthru-earth/objex) to [https://objex.labs.dataforcanada.org/](https://objex.labs.dataforcanada.org/).

While an S3 API is perfect for code, sometimes you just need to look around. Objex provides a lightweight, clean, and intuitive web interface for browsing our storage buckets. This allows anyone to navigate through directory structures, discover what files are available, and download data directly from their browser—no command-line tools or specialized software required. 


### Supported Formats
As of May 3, 2026, objex supports over 100 file formats.

| Category | Formats |
|----------|---------|
| Tabular | Parquet, CSV, TSV, JSONL, NDJSON |
| Geo vector | GeoParquet, GeoJSON, Shapefile, GeoPackage, FlatGeobuf |
| Geo raster | COG, PMTiles, Zarr v2/v3, GeoZarr |
| Geo catalog | STAC Item / Collection / Catalog / FeatureCollection (JSON), stac-geoparquet |
| Point cloud | COPC, LAZ, LAS |
| Notebooks | Jupyter (.ipynb), marimo |
| Code | 30+ languages (Python, TS, Rust, Go, SQL...) |
| Documents | Markdown, PDF, text, logs |
| Media | Images, video, audio |
| 3D | GLB, glTF, OBJ, STL, FBX |
| Archives | ZIP, TAR, GZ, 7Z, RAR |
| Database | DuckDB, SQLite |

## What’s Next?
By pairing a standardized S3 API with a human-readable explorer, we are bridging the gap between heavy-duty engineering requirements and general public accessibility.

Take a look around the new explorer, test out the S3 endpoint in your workflows, and stay tuned for more updates as we continue to build out the Data for Canada infrastructure!