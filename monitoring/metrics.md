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


## TOTAL REQUESTS

### **Metric:** `prometheus_exporter_requests_total`

#### **Description**  
Records the **total number of HTTP requests** received by the service.

#### **Value Interpretation**  
- **Each increment in this counter** represents a new processed request.
- **The absolute value of this metric** indicates the total number of requests since data collection started.

#### **Example Prometheus Output**

# HELP prometheus_exporter_requests_total Number of HTTP requests received.
# TYPE prometheus_exporter_requests_total counter
prometheus_exporter_requests_total 1

## BATCH PUT LATENCY

### **Metric:** `rockbound_batch_put_latency_seconds`

#### **Description**  
Measures the **latency** of batch put operations in Rockbound Schema, reported in **seconds**.  
This metric is recorded as a **histogram**, allowing analysis of the distribution of batch put latencies across different time intervals.

#### **Value Interpretation**  
Each bucket in the histogram represents the number of batch put operations with a duration **less than or equal** to the specified threshold.

| Threshold (`le`) | Number of Operations in Range |
|-----------------|------------------------------|
| `0.001s`       | 1017 operations               |
| `0.002s`       | 1017 operations               |
| `0.004s`       | 1017 operations               |
| `0.008s`       | 1017 operations               |
| `0.016s`       | 1017 operations               |
| `0.032s`       | 1017 operations               |
| `0.064s`       | 1017 operations               |
| `0.128s`       | 1017 operations               |
| `0.256s`       | 1017 operations               |
| `0.512s`       | 1017 operations               |
| `1.024s`       | 1017 operations               |
| `2.048s`       | 1017 operations               |
| `4.096s`       | 1017 operations               |
| `8.192s`       | 1017 operations               |
| `16.384s`      | 1017 operations               |
| `32.768s`      | 1017 operations               |
| `65.536s`      | 1017 operations               |
| `131.072s`     | 1017 operations               |
| `262.144s`     | 1017 operations               |
| `524.288s`     | 1017 operations               |
| `+Inf`         | 1017 operations               |

- **Cumulative Metrics:**  
  - `rockbound_batch_put_latency_seconds_sum` represents the **total time spent** processing batch put operations.
  - `rockbound_batch_put_latency_seconds_count` represents the **total number of batch put operations recorded**.

#### **Example Prometheus Output**

# HELP rockbound_batch_put_latency_seconds rockbound schema batch put latency in seconds
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
rockbound_batch_put_latency_seconds_count{db_name="unknown"} 1017```

## PROMETHEUS EXPORTER RESPONSE SIZE
### Metric: `prometheus_exporter_response_size_bytes`

**Description:**  
Indicates the **size of the HTTP response** generated by the Prometheus exporter, measured in bytes. This metric helps monitor the resource consumption of Prometheus' HTTP responses, which can impact performance if responses become too large.

**Example Value:**  
- `37821` bytes.

**Interpretation:**  
- **Normal values** indicate stable exporter performance.
- **Sudden increases** might suggest excessive data being retrieved, potentially impacting Prometheus' efficiency.
- **Consistently high values** could indicate the need for query optimization or limiting the amount of data retrieved per request.


