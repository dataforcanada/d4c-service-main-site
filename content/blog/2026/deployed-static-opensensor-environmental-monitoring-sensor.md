---
title: Deployed an Open Sensor Environmental Station Using Raspberry Pi and Enviro+
summary: I deployed a static environmental monitoring station that contributes readings to the Open Sensor network, and made the raw sensor and health data openly available on Source Cooperative.
date: 2026-04-22T10:00:00-04:00
authors:
  - name: diegoripley
    link: https://github.com/diegoripley
    image: https://github.com/diegoripley.png
tags:
  - hardware
  - raspberry-pi
  - environmental-monitoring
  - open-data
excludeSearch: false
---

I recently deployed a static environmental monitoring station that contributes readings to the [Open Sensor](https://opensensor.space) network. This is a quick post describing what the station is, how it is built, and where you can access the data it produces.

## 1. What is Open Sensor?
[Open Sensor](https://opensensor.space) is a community-run network of low-cost environmental sensors. Each station publishes its readings in an open and efficient file format so that anyone can use them. You can read more about how the network is designed on the [architecture page](https://opensensor.space/architecture/).

## 2. Hardware
The station follows Open Sensor's reference build, which is documented under [hardware requirements](https://opensensor.space/join-network/#1-hardware-requirements). At a high level, it consists of:

- A **Raspberry Pi Zero 2 W** as the host computer.
- A **Pimoroni Enviro+** HAT, which provides sensors for temperature, humidity, pressure, light, noise, and air quality (gas and particulate matter when paired with a PMS5003).

Once the hardware was assembled, the Pi was flashed with the Raspberry Pi OS Lite image, and the [OpenSensor Enviroplus](https://github.com/walkthru-earth/opensensor-enviroplus) was installed and configured to upload data to Source Cooperative.

![d4c-opensensor-01](/blog/2026/deployed-static-opensensor-environmental-monitoring-sensor/d4c-opensensor-01.webp)

## 3. Data
The station is registered on the network with the identifier [`019d97ff-3220-74fc-8923-f9fb69e2273d`](https://opensensor.space/Stations/019d97ff-3220-74fc-8923-f9fb69e2273d/). The publicly listed location for this station is set to the [Central Experimental Farm](https://en.wikipedia.org/wiki/Central_Experimental_Farm) rather than my actual deployment site; I did not want to give away my home location, and the Experimental Farm happens to be one of my favourite places in Ottawa. Once I move locations, I will retroactively update the station location.

Two datasets are archived on [Source Cooperative](https://source.coop) under the [`d4c-datapkg-environment-climate-health`](https://source.coop/dataforcanada/d4c-datapkg-environment-climate-health) data package:

- **Sensor readings** (temperature, humidity, pressure, gas, particulates, etc.):  
  [`archive/opensensor.space/enviroplus/station=019d97ff-3220-74fc-8923-f9fb69e2273d`](https://source.coop/dataforcanada/d4c-datapkg-environment-climate-health/archive/opensensor.space/enviroplus/station=019d97ff-3220-74fc-8923-f9fb69e2273d)
- **Station health metrics** (CPU temperature, uptime, memory, etc.):  
  [`archive/opensensor.space/enviroplus-health/station=019d97ff-3220-74fc-8923-f9fb69e2273d`](https://source.coop/dataforcanada/d4c-datapkg-environment-climate-health/archive/opensensor.space/enviroplus-health/station=019d97ff-3220-74fc-8923-f9fb69e2273d)

Both datasets are partitioned by station, which makes it straightforward to query only this station with tools such as DuckDB, or to combine it with other stations in the network. The query below gathers the last 12 hours of readings and plots the temperature as a line graph.

```python
import duckdb
import seaborn as sns

sns.set_theme()

con = duckdb.connect()
con.install_extension("httpfs")
con.load_extension("httpfs")

# Last 15 minutes of readings
result = con.sql("""
    SELECT *
    FROM read_parquet(
        's3://us-west-2.opendata.source.coop/dataforcanada/d4c-datapkg-environment-climate-health/archive/opensensor.space/enviroplus/station=019d97ff-3220-74fc-8923-f9fb69e2273d/**/*.parquet',
        hive_partitioning = true
    )
    WHERE timestamp >= now() - INTERVAL 12 HOUR
    ORDER BY timestamp DESC;
""")

result_df = result.df()
result_df

# Quick Plot on temperature across time
sns.lineplot(data=result_df, x='timestamp', y='temperature')
```

## 4. The Future: Scalable Environmental Governance
The real value lies in scaling this into a high-density network to support **governance**, bridging the gap between urban and rural environments. Because these sensors are portable and low-cost, they can be deployed across diverse landscapes to drive **intelligent decision-making** and policy:

* **Urban:** Driving real-time traffic signal adjustments, dynamic speed limits, and pollution-aware routing.
* **Rural & Wilderness:** Monitoring cross-border air pollution, wildfire smoke drift, and micro-climate changes in protected natural areas.

I’ve already purchased a second station to take into the field. By syncing both the Pi and my phone to the same time server (NTP), I can join the air quality readings with my phone's GPS track using timestamps. This turns future hikes into mobile environmental surveys, mapping the environment one trail at a time.


## 5. Join the Network
[Join the network](https://opensensor.space/join-network/), it is super easy, it took me less than 2 hours to get everything working.

![d4c-opensensor-01](/blog/2026/deployed-static-opensensor-environmental-monitoring-sensor/opensensor-network-growing.webp)
