# Spicenet Consensus System Metrics Documentation

## Introduction

This document provides a detailed reference for the metrics used in the **Spicenet** consensus system. These metrics, collected through **Prometheus**, are essential for monitoring the performance, security, and health of the nodes in the network.

The document is structured into different metric categories, including **HTTP request latency, total processed requests, batch operation performance, and response sizes**. Each metric is described with its meaning, value interpretation, and example data.

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
Measures the latency of HTTP requests in **seconds**. This metric is reported as a **histogram**, allowing analysis of response time distribution across different time intervals.

**Value Interpretation:**  
Each bucket in the histogram represents the number of requests with a duration **less than or equal** to the specified threshold.

| Threshold (`le`) | Number of Requests in Range |
|-----------------|----------------------------|
| `0.005s`       | 1 request                   |
| `0.01s`        | 1 request                   |
| `0.025s`       | 1 request                   |
| `0.05s`        | 1 request                   |
| `0.1s`         | 1 request                   |
| `0.25s`        | 1 request                   |
| `0.5s`         | 1 request                   |
| `1s`           | 1 request                   |
| `2.5s`         | 1 request                   |
| `5s`           | 1 request                   |
| `10s`          | 1 request                   |
| `+Inf`         | 1 request                   |

- **Cumulative Metrics:**  
  - `prometheus_exporter_request_duration_seconds_sum`: Total time spent processing all requests.
  - `prometheus_exporter_request_duration_seconds_count`: Total number of recorded requests.

---

## Total Requests

### Metric: `prometheus_exporter_requests_total`

**Description:**  
Records the **total number of HTTP requests** received by the service.

**Value Interpretation:**  
- **Each increment in this counter** represents a new processed request.
- **The absolute value of this metric** indicates the total number of requests since data collection started.

**Example Prometheus Output:**
```plaintext
# HELP prometheus_exporter_requests_total Number of HTTP requests received.
# TYPE prometheus_exporter_requests_total counter
prometheus_exporter_requests_total 1
