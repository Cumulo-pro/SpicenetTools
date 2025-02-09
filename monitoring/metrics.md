# Spicenet Consensus System Metrics Documentation

## Introduction

This document provides a detailed reference for the metrics used in the **Spicenet** consensus system. These metrics, collected through **Prometheus**, are essential for monitoring the performance, security, and health of the nodes in the network.

The document is structured into different metric categories, including **HTTP request latency**, **total processed requests**, **batch operation performance**, and **response sizes**. Each metric is described with its meaning, value interpretation, and example data.

By leveraging these metrics, network operators and developers can ensure optimal performance, detect potential issues, and maintain a secure and efficient blockchain environment.

For ease of navigation, please refer to the **Table of Contents** below.

---

## Table of Contents

- [Request Duration](#request-duration)
- [Total Requests](#total-requests)
- [Batch Put Latency](#batch-put-latency)
- [Prometheus Exporter Response Size](#prometheus-exporter-response-size)

---

## Request Duration

### Metric: `prometheus_exporter_request_duration_seconds`

**Description:**  
Measures the **latency** of HTTP requests in **seconds**. This metric is recorded as a **histogram**, allowing analysis of response time distribution across different time intervals.


# HELP prometheus_exporter_request_duration_seconds HTTP request latency in seconds.
# TYPE prometheus_exporter_request_duration_seconds histogram
prometheus_exporter_request_duration_seconds_bucket{le="0.005"} 1
prometheus_exporter_request_duration_seconds_bucket{le="0.01"} 1
prometheus_exporter_request_duration_seconds_bucket{le="0.025"} 1
prometheus_exporter_request_duration_seconds_bucket{le="0.05"} 1
prometheus_exporter_request_duration_seconds_bucket{le="0.1"} 1
prometheus_exporter_request_duration_seconds_bucket{le="0.25"} 1
prometheus_exporter_request_duration_seconds_bucket{le="0.5"} 1
prometheus_exporter_request_duration_seconds_bucket{le="1"} 1
prometheus_exporter_request_duration_seconds_bucket{le="2.5"} 1
prometheus_exporter_request_duration_seconds_bucket{le="5"} 1
prometheus_exporter_request_duration_seconds_bucket{le="10"} 1
prometheus_exporter_request_duration_seconds_bucket{le="+Inf"} 1
prometheus_exporter_request_duration_seconds_sum 0.001
prometheus_exporter_request_duration_seconds_count 1

## Total Requests


Metric: prometheus_exporter_requests_total
Description:
Records the total number of HTTP requests received by the service.

# HELP prometheus_exporter_requests_total Number of HTTP requests received.
# TYPE prometheus_exporter_requests_total counter
prometheus_exporter_requests_total 1

## Batch Put Latency


Metric: rockbound_batch_put_latency_seconds
Description:
Measures the latency of batch put operations in Rockbound Schema, reported in seconds.
This metric is recorded as a histogram, allowing analysis of the distribution of batch put latencies across different time intervals.

# HELP rockbound_batch_put_latency_seconds Rockbound schema batch put latency in seconds.
# TYPE rockbound_batch_put_latency_seconds histogram
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.001"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.002"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.004"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.008"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.016"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.032"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.064"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.128"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.256"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="0.512"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="1.024"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="2.048"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="4.096"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="8.192"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="16.384"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="32.768"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="65.536"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="131.072"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="262.144"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="524.288"} 1017
rockbound_batch_put_latency_seconds_bucket{db_name="unknown",le="+Inf"} 1017
rockbound_batch_put_latency_seconds_sum{db_name="unknown"} 0.0011603689999999999
rockbound_batch_put_latency_seconds_count{db_name="unknown"} 1017

