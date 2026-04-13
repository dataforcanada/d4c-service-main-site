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
    { id: 'source-cooperative-oregon', name: 'Source Cooperative', location: 'Oregon, USA', coords: [-122.68, 45.52], specs: 'AWS S3 (us-west-2), ~50TB HDD Storage', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'r2', name: 'Cloudflare R2', location: 'Eastern North America', coords: [-73.94, 40.71], specs: 'Primary Object Storage', protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'san-francisco', name: 'The Internet Archive', location: 'San Francisco, California, USA', coords: [-122.42, 37.77], protocol: 'HTTP', jurisdiction: 'USA', color: '#002147' },
    { id: 'vps-01', name: 'VPS 01', location: 'Manassas, Virginia, USA', coords: [-77.48, 38.75], specs: '2.5Gbps / 2.5Gbps, 512GB Flash Storage', protocol: 'All', jurisdiction: 'Germany', color: '#FFCC00' },
    { id: 'backup-node-01', name: 'Backup Node 01', location: 'Fremont, California, USA', specs: '10Gbps / 10Gbps, 2TB Storage', coords: [-121, 40], protocol: 'SSH, Multi', jurisdiction: 'USA', color: '#002147' },
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
    { source: 'san-francisco', target: 'vancouver', color: '#002147' },
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

  // ── Node offset helpers ───────────────────────────────────────────────────
  const nodesByLocation = {};
  nodes.forEach(node => {
    const key = node.coords.join(',');
    if (!nodesByLocation[key]) nodesByLocation[key] = [];
    nodesByLocation[key].push(node);
  });

  const nodeOffsets = {};
  Object.values(nodesByLocation).forEach(nodesAtLocation => {
    if (nodesAtLocation.length === 1) {
      nodeOffsets[nodesAtLocation[0].id] = { dx: 0, dy: 0 };
    } else {
      const radius = 8;
      nodesAtLocation.forEach((node, i) => {
        const angle = (i / nodesAtLocation.length) * 2 * Math.PI;
        nodeOffsets[node.id] = {
          dx: Math.cos(angle) * radius,
          dy: Math.sin(angle) * radius
        };
      });
    }
  });

  // ── Tooltip ───────────────────────────────────────────────────────────────
  const tooltip = d3.select('.tooltip');

  function showTooltip(event, nodesAtLocation) {
    let html = '';
    nodesAtLocation.forEach((node, i) => {
      if (i > 0) html += '<hr style="margin:8px 0;border:none;border-top:1px solid #ccc;">';
      html += `<div class="tooltip-title">${node.name}</div>`;
      html += `<div class="tooltip-detail">Location: ${node.location}</div>`;
      if (node.specs)    html += `<div class="tooltip-detail">Specs: ${node.specs}</div>`;
      if (node.protocol) html += `<div class="tooltip-detail">Protocol: ${node.protocol}</div>`;
      html += `<div class="tooltip-detail">Jurisdiction: ${node.jurisdiction}</div>`;
    });
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
      const source = nodes.find(n => n.id === conn.source);
      const target = nodes.find(n => n.id === conn.target);
      if (source && target) {
        connGroup.append('path')
          .datum({ type: 'LineString', coordinates: [source.coords, target.coords] })
          .attr('class', 'connection')
          .attr('d', path)
          .attr('stroke', conn.color);
      }
    });

    // Nodes
    const nodeGroup = g.append('g');
    nodes.forEach(node => {
      const [cx, cy]          = projection(node.coords);
      const { dx, dy }         = nodeOffsets[node.id];
      const locationKey        = node.coords.join(',');
      const nodesAtThisLocation = nodesByLocation[locationKey];

      nodeGroup.append('circle')
        .attr('class', 'node')
        .attr('cx', cx + dx)
        .attr('cy', cy + dy)
        .attr('r', 4)
        .attr('fill', node.color)
        .on('mouseover', (event) => showTooltip(event, nodesAtThisLocation))
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
