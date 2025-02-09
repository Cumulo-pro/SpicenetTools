# Spicenet Consensus System Metrics Documentation

## Introduction

This document provides a detailed reference for the metrics used in the **Spicenet** consensus system. These metrics, collected through **Prometheus**, are essential for monitoring the performance, security, and health of the nodes in the network.

The document is structured into different metric categories, including **HTTP request latency** and **total processed requests**. Each metric is described with its meaning, value interpretation, and example data.

By leveraging these metrics, network operators and developers can ensure optimal performance, detect potential issues, and maintain a secure and efficient blockchain environment.

For ease of navigation, please refer to the **Table of Contents** below.

---

## Table of Contents

- [REQUEST DURATION](#request-duration)
- [TOTAL REQUESTS](#total-requests)

---

## REQUEST DURATION

### **Metric:** `prometheus_exporter_request_duration_seconds`

#### **Description**  
Measures the latency of HTTP requests in **seconds**. This metric is reported as a **histogram**, allowing analysis of response time distribution across different time intervals.

#### **Value Interpretation**  
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

- **Cumulative Metric:**  
  - `prometheus_exporter_request_duration_seconds_sum` represents the **total time** spent processing all requests.
- **Total Count:**  
  - `prometheus_exporter_request_duration_seconds_count` represents the **total number of recorded requests**.

#### **Example Prometheus Output**
```plaintext
# HELP prometheus_exporter_request_duration_seconds The HTTP request latencies in seconds.
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
prometheus_exporter_request_duration_seconds_sum 0.000001114
prometheus_exporter_request_duration_seconds_count 1
