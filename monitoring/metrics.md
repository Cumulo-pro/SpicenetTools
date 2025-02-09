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

## HTTP REQUEST LATENCY
### Metric: `prometheus_exporter_request_duration_seconds`

**Description:**  
The **HTTP Request Latency Metric** measures the time taken for HTTP requests to be processed by the Prometheus exporter. This metric is recorded as a **histogram**, allowing for the analysis of response time distribution across different time intervals.  

Tracking request latency is crucial for identifying performance bottlenecks, ensuring system responsiveness, and diagnosing potential delays in HTTP request handling.  

**Value Interpretation:**  
Each bucket represents the number of requests that were processed within the specified duration threshold.  

| Latency Threshold | Request Count |
|------------------|--------------|
| `≤ 0.005s`      | 4 requests   |
| `≤ 0.01s`       | 4 requests   |
| `≤ 0.025s`      | 4 requests   |
| `≤ 0.05s`       | 4 requests   |
| `≤ 0.1s`        | 4 requests   |
| `≤ 0.25s`       | 4 requests   |
| `≤ 0.5s`        | 4 requests   |
| `≤ 1s`          | 4 requests   |
| `≤ 2.5s`        | 4 requests   |
| `≤ 5s`          | 4 requests   |
| `≤ 10s`         | 4 requests   |
| `+Inf`          | 4 requests   |

- **Total Latency Time:** `0.000004638` seconds.  
- **Total Number of Requests:** `4`.  

Monitoring this metric helps optimize system performance by reducing high-latency responses and ensuring that request processing remains efficient.

