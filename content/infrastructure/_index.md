---
title: Infrastructure
sidebar:
  open: true
---

## High-Level Overview

{{< rawhtml >}}
<style>
  .land {
    fill: #ddd;
    stroke: #999;
    stroke-width: 0.5;
  }

  .graticule {
    fill: none;
    stroke: #ccc;
    stroke-width: 0.5;
  }

  .connection {
    fill: none;
    stroke-width: 1.5;
    opacity: 0.6;
  }

  .node {
    cursor: pointer;
    stroke: #fff;
    stroke-width: 1;
  }

  .tooltip {
    position: absolute;
    background: white;
    border: 1px solid #ccc;
    padding: 10px;
    pointer-events: none;
    opacity: 0;
    transition: opacity 0.2s;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    max-width: 350px;
  }

  .tooltip.visible {
    opacity: 1;
  }

  .tooltip-title {
    font-weight: bold;
    margin-bottom: 5px;
  }

  .tooltip-detail {
    font-size: 10px;
    margin: 2px 0;
  }

  /* Make the map fill its container and stay 750:400 */
  #map-container {
    width: 100%;
    position: relative;
  }

  #map {
    display: block;
    width: 100%;
    height: auto;
    cursor: grab;
  }

  #map:active {
    cursor: grabbing;
  }

  /* Small reset-zoom button */
  #zoom-reset {
    position: absolute;
    top: 8px;
    right: 8px;
    background: white;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 4px 8px;
    font-size: 12px;
    cursor: pointer;
    box-shadow: 0 1px 3px rgba(0,0,0,0.15);
    user-select: none;
  }

  #zoom-reset:hover {
    background: #f5f5f5;
  }
</style>

<div id="map-container">
  <svg id="map"></svg>
  <button id="zoom-reset" title="Reset zoom">⟳ Reset</button>
</div>
<div class="tooltip"></div>

<script type="module">
  import * as d3 from 'https://cdn.jsdelivr.net/npm/d3@7/+esm';

  // ── Data ─────────────────────────────────────────────────────────────────
  const nodes = [
    /*
    { id: 'smart-node-01', name: 'Smart Node 01', location: 'Toronto, Ontario, Canada', coords: [-79.38, 43.65], specs: '50Gbps / 50Gbps, 950GB Flash Storage', protocol: 'P2P, SSH', jurisdiction: 'Singapore', color: '#9966CC' },
    */
    { id: 'geo-services-01', name: 'Geo Services 01', location: 'Ottawa, Ontario, Canada', coords: [-75.69, 45.42], specs: '3GBps / 3GBps, 60TB HDD Storage, 14TB Flash Storage', protocol: 'All', jurisdiction: 'Canada', color: '#EA2839' },
    { id: 'vancouver', name: 'Internet Archive Mirror', location: 'Vancouver, Canada', coords: [-123.12, 49.28], protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'source-cooperative-ca-central', name: 'Source Cooperative', location: 'Montreal, Quebec, Canada', coords: [-73.57, 45.50], specs: 'AWS S3 (ca-central-1), ~50TB HDD Storage', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'r2-enam', name: 'Cloudflare R2 ENAM', location: 'Eastern North America', coords: [-73.94, 40.71], specs: 'Primary Object Storage', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'r2-apac', name: 'Cloudflare R2 APAC', location: 'Asia-Pacific', coords: [103.82, 1.35], specs: 'Primary Object Storage', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'backup-node-01', name: 'Backup Node 01', location: 'Fremont, California, USA', specs: '10Gbps / 10Gbps, 2TB Storage', coords: [-121.99, 37.55], protocol: 'SSH, Multi', jurisdiction: 'USA', color: '#002147' },
    { id: 'internet-archive-san-francisco', name: 'The Internet Archive', location: 'San Francisco, California, USA', coords: [-122.42, 37.77], protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'vps-01', name: 'VPS 01', location: 'Manassas, Virginia, USA', coords: [-77.48, 38.75], specs: '2.5Gbps / 2.5Gbps, 512GB Flash Storage', protocol: 'All', jurisdiction: 'Germany', color: '#FFCC00' },
    /*
    { id: 'smart-node-02', name: 'Smart Node 02', location: 'Amsterdam, Netherlands', coords: [4.90, 52.37], specs: '50Gbps / 50Gbps, 950GB Flash Storage', protocol: 'P2P, SSH', jurisdiction: 'Singapore', color: '#9966CC' },
    { id: 'smart-node-03', name: 'Smart Node 03', location: 'Amsterdam, Netherlands', coords: [4.90, 52.37], specs: '50Gbps / 50Gbps, 6TB HDD Storage', protocol: 'P2P, SSH', jurisdiction: 'Singapore', color: '#9966CC' },
    */
    { id: 'geneva', name: 'Zenodo', location: 'Geneva, Switzerland', coords: [6.14, 46.20], specs: 'Replicated in Budapest', protocol: 'HTTP', jurisdiction: 'Switzerland', color: '#FFFFFF' },
    { id: 'budapest', name: 'Zenodo Mirror', location: 'Budapest, Hungary', coords: [19.04, 47.50], protocol: 'HTTP', jurisdiction: 'Switzerland', color: '#FFFFFF' },
    { id: 'tigris-ams', name: 'Tigris (Amsterdam)', location: 'Amsterdam, Netherlands', coords: [4.90, 52.37], specs: 'Tigris CDN Region (ams)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-fra', name: 'Tigris (Frankfurt)', location: 'Frankfurt, Germany', coords: [8.68, 50.11], specs: 'Tigris CDN Region (fra)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-gru', name: 'Tigris (São Paulo)', location: 'São Paulo, Brazil', coords: [-46.63, -23.55], specs: 'Tigris CDN Region (gru)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-iad', name: 'Tigris (Ashburn)', location: 'Ashburn, Virginia, USA', coords: [-77.49, 39.04], specs: 'Tigris CDN Region (iad)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-jnb', name: 'Tigris (Johannesburg)', location: 'Johannesburg, South Africa', coords: [28.04, -26.20], specs: 'Tigris CDN Region (jnb)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-lhr', name: 'Tigris (London)', location: 'London, United Kingdom', coords: [-0.13, 51.51], specs: 'Tigris CDN Region (lhr)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-nrt', name: 'Tigris (Tokyo)', location: 'Tokyo, Japan', coords: [139.69, 35.69], specs: 'Tigris CDN Region (nrt)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-ord', name: 'Tigris (Chicago)', location: 'Chicago, Illinois, USA', coords: [-87.63, 41.88], specs: 'Tigris CDN Region (ord)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-sin', name: 'Tigris (Singapore)', location: 'Singapore', coords: [103.82, 1.35], specs: 'Tigris CDN Region (sin)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-sjc', name: 'Tigris (San Jose)', location: 'San Jose, California, USA', coords: [-121.89, 37.34], specs: 'Tigris CDN Region (sjc)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'tigris-syd', name: 'Tigris (Sydney)', location: 'Sydney, Australia', coords: [151.21, -33.87], specs: 'Tigris CDN Region (syd)', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' }
  ];

  const connections = [
    { source: 'internet-archive-san-francisco', target: 'vancouver', color: '#002147' },
    { source: 'geneva', target: 'budapest', color: '#FFFFFF' }
  ];

  // ── Dimensions (logical — the viewBox coordinate space) ───────────────────
  const width  = 750;
  const height = 400;

  // ── SVG — responsive via viewBox ─────────────────────────────────────────
  const svg = d3.select('#map')
    .attr('viewBox', `0 0 ${width} ${height}`)
    .attr('preserveAspectRatio', 'xMidYMid meet');

  // ── Projection ────────────────────────────────────────────────────────────
  const projection = d3.geoNaturalEarth1()
    .scale(100)
    .center([-75, 65])
    .translate([width / 2, height / 2]);

  const path      = d3.geoPath().projection(projection);
  const graticule = d3.geoGraticule();

  const g = svg.append('g');

  // ── Zoom behaviour ────────────────────────────────────────────────────────
  const zoom = d3.zoom()
    .scaleExtent([1, 12])          // min 1× (full map), max 12×
    .translateExtent([[0, 0], [width, height]])  // can't pan beyond the viewBox
    .on('zoom', (event) => {
      g.attr('transform', event.transform);
    });

  svg.call(zoom);

  // Reset button
  d3.select('#zoom-reset').on('click', () => {
    svg.transition().duration(500).call(zoom.transform, d3.zoomIdentity);
  });

  // ── Graticule ─────────────────────────────────────────────────────────────
  g.append('path')
    .datum(graticule)
    .attr('class', 'graticule')
    .attr('d', path);

  // ── Node layout ───────────────────────────────────────────────────────────
  // At this scale plenty of distinct sites project within a few pixels of each
  // other — the Bay Area, Ashburn and Manassas, the western European hosts — and
  // some share coordinates outright. Start every node at its true position, then
  // nudge overlapping pairs apart until each circle is separately visible. This
  // keeps nodes as close to their real location as legibility allows.
  const nodeRadius  = 4;
  const minDistance = nodeRadius * 2 + 1;   // leave a pixel of daylight between circles

  const nodePositions = {};
  nodes.forEach(node => {
    const [x, y] = projection(node.coords);
    nodePositions[node.id] = { x, y };
  });

  for (let pass = 0; pass < 100; pass++) {
    let moved = false;

    for (let i = 0; i < nodes.length; i++) {
      for (let j = i + 1; j < nodes.length; j++) {
        const a = nodePositions[nodes[i].id];
        const b = nodePositions[nodes[j].id];

        let dx = b.x - a.x;
        let dy = b.y - a.y;
        let distance = Math.hypot(dx, dy);

        // Nodes sharing exact coordinates need a deterministic direction to
        // separate along; the golden angle keeps successive picks well spread.
        if (distance === 0) {
          dx = Math.cos(j * 2.399);
          dy = Math.sin(j * 2.399);
          distance = 1;
        }

        if (distance < minDistance - 0.01) {
          const shift = (minDistance - distance) / 2 / distance;
          a.x -= dx * shift;
          a.y -= dy * shift;
          b.x += dx * shift;
          b.y += dy * shift;
          moved = true;
        }
      }
    }

    if (!moved) break;
  }

  // ── Tooltip ───────────────────────────────────────────────────────────────
  const tooltip = d3.select('.tooltip');

  function showTooltip(event, node) {
    let html = '';
    html += `<div class="tooltip-title">${node.name}</div>`;
    html += `<div class="tooltip-detail">Location: ${node.location}</div>`;
    if (node.specs)    html += `<div class="tooltip-detail">Specs: ${node.specs}</div>`;
    if (node.protocol) html += `<div class="tooltip-detail">Protocol: ${node.protocol}</div>`;
    html += `<div class="tooltip-detail">Jurisdiction: ${node.jurisdiction}</div>`;

    tooltip.html(html).classed('visible', true)
      .style('left', (event.pageX + 15) + 'px')
      .style('top',  (event.pageY + 15) + 'px');
  }

  function hideTooltip() {
    tooltip.classed('visible', false);
  }

  // ── Load world map and render ─────────────────────────────────────────────
  d3.json('https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_110m_land.geojson').then(landData => {

    // Land
    g.append('g')
      .selectAll('path')
      .data(landData.features)
      .enter().append('path')
      .attr('class', 'land')
      .attr('d', path);

    // Connections
    const connGroup = g.append('g');
    connections.forEach(conn => {
      const source = nodePositions[conn.source];
      const target = nodePositions[conn.target];
      if (source && target) {
        connGroup.append('line')
          .attr('class', 'connection')
          .attr('x1', source.x).attr('y1', source.y)
          .attr('x2', target.x).attr('y2', target.y)
          .attr('stroke', conn.color);
      }
    });

    // Nodes
    const nodeGroup = g.append('g');
    nodes.forEach(node => {
      const { x, y } = nodePositions[node.id];

      nodeGroup.append('circle')
        .attr('class', 'node')
        .attr('cx', x)
        .attr('cy', y)
        .attr('r', nodeRadius)
        .attr('fill', node.color)
        .on('mouseover', (event) => showTooltip(event, node))
        .on('mouseout',  hideTooltip)
        .on('mousemove', (event) => {
          tooltip
            .style('left', (event.pageX + 15) + 'px')
            .style('top',  (event.pageY + 15) + 'px');
        });
    });
  });
</script>
{{< /rawhtml >}}

## Roadmap: Resilience & Transparency

To support our mission of providing high-performance, analysis-ready data, we are currently developing a suite of public tools to make this distributed ecosystem more **FAIR** (Findable, Accessible, Interoperable, Reusable), **resilient**, and **transparent**.

These planned features are designed to help researchers and automated systems coordinate data access across the various platforms and mirrors we utilize.

### 1. Real-Time Service Status

We are building a comprehensive status dashboard that monitors the availability of the diverse storage locations we rely on, from our own Smart Nodes to external providers like the Internet Archive, Source Cooperative, and Zenodo. Users will be able to verify if a specific mirror is operational before initiating workflows.

### 2. Traffic & Load Optimization Statistics

To foster better cooperation between our systems and downstream users, we plan to expose traffic and connectivity statistics where possible.

This transparency allows automated systems to be "smart" about data retrieval. For example, a system could query these statistics to schedule bandwidth-intensive HTTP downloads during non-peak hours, or adjust behavior based on current connectivity loads during high-traffic periods of the workday. This improves performance for individual users while respecting the bandwidth constraints of the various host providers.

### 3. Community Issue Reporting

We are introducing a streamlined method for users to report access issues across any of the services we aggregate. By allowing the community to flag connectivity drops or data integrity issues quickly, we can identify bottlenecks or outages at specific providers and route users to alternative sources more effectively.
