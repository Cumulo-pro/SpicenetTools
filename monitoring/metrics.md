# Spicenet Consensus System Metrics Documentation

## Introduction

This document provides a detailed reference for the metrics used in the **Spicenet** consensus system. These metrics, collected through **Prometheus**, are essential for monitoring the performance, security, and health of the nodes in the network.

The document is structured into different metric categories, including **HTTP request latency**, **total processed requests**, **batch operation performance**, and **response sizes**. Each metric is described with its meaning, value interpretation, and example data.

By leveraging these metrics, network operators and developers can ensure optimal performance, detect potential issues, and maintain a secure and efficient blockchain environment.

For ease of navigation, please refer to the **Table of Contents** below.

---

## Table of Contents

- [Introduction](#introduction)
- [Request Duration](#http-request-latency)
- [Total Requests](#total-http-requests)
- [HTTP Response Size](#http-response-size)
- [Batch Put Latency](#batch-put-latency)
- [Rockbound Put Data Size](#rockbound-put-data-size)
- [SchemaDB Batch Commit Size](#schemadb-batch-commit-size)
- [SchemaDB Batch Commit Latency](#schemadb-batch-commit-latency)
- [SchemaDB Get Data Size](#schemadb-get-data-size)
- [SchemaDB Get Latency](#schemadb-get-latency)
- [SchemaDB Iteration Latency](#schemadb-iteration-latency)

---

# Node metricas

### LATEST ROLLUP HEIGHT  
**Metric**: `latest_rollup_height`  
**Description**:  
The `latest_rollup_height` metric represents the most recent rollup height in Spicenet.  

Tracking this metric is vital for understanding the current state of the rollup and ensuring that it is up to date with the latest blocks. It provides insight into the progress and health of the rollup, which is crucial for systems relying on up-to-date block heights.  

**Value Interpretation**:  
The value of this metric indicates the current height of the rollup. A higher value suggests the rollup is progressing forward with new block heights.

**Example Value**:  
`latest_rollup_height 131419`  

---

### LAST FINALIZED HEIGHT  
**Metric**: `last_finalized_height`  
**Description**:  
The `last_finalized_height` metric records the block height of the last finalized block in Spicenet, which corresponds to the last block in the Celestia chain. Like the previous metric, it is a gauge that reflects changes over time as new blocks are finalized.  

Monitoring this metric is essential to ensure that the system is consistently processing blocks and finalizing them as expected. A sudden discrepancy between `latest_rollup_height` and `last_finalized_height` may indicate an issue with block finalization.

**Value Interpretation**:  
This value represents the height of the last block that was finalized in the Celestia chain. If this value is lower than the rollup height, it may suggest a delay or issue in finalizing blocks.

**Example Value**:  
`last_finalized_height 4672419`  

---

### ERROR COUNT  
**Metric**: `error_count`  
**Description**:  
The `error_count` metric tracks the number of errors that have occurred in the Spicenet logs. It is a gauge that reflects the real-time count of errors, helping identify any issues or failures within the system.

Monitoring error counts is crucial for ensuring system reliability and troubleshooting. A sudden spike in errors can indicate potential problems in the system that need attention.

**Value Interpretation**:  
Each increment represents one new error. A value of `0` suggests no errors, while higher values signal that more errors have been encountered.

**Example Value**:  
`error_count 1`  

---

### EXECUTION TIME  
**Metric**: `execution_time`  
**Description**:  
The `execution_time` metric records the time taken to process the last block in Spicenet, measured in seconds. It is a gauge metric that tracks the processing time, helping identify performance bottlenecks or delays in block execution.

This metric is useful for evaluating the system's processing efficiency and responsiveness. A sudden increase in execution time may indicate system strain or issues in processing.

**Value Interpretation**:  
The value represents the time taken for the latest block's execution in seconds. A lower value indicates faster processing, while a higher value might suggest slower performance or a need for optimization.

**Example Value**:  
`execution_time 4.836305857`  

---

### EXECUTION BLOCK  
**Metric**: `execution_block`  
**Description**:  
The `execution_block` metric records the block height of the last completed execution in Spicenet. This is a gauge metric that provides insight into the progress of the system in completing block executions.

Tracking this metric helps operators monitor the health of the node and ensure that block execution is happening consistently. It is important for verifying that the system is processing and executing blocks as expected.

**Value Interpretation**:  
This value represents the height of the last executed block. If the value is high and consistently increasing, it indicates that the system is processing blocks at a healthy rate.

**Example Value**:  
`execution_block 4672419`  


---

# Prometheus metrics

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

## TOTAL HTTP REQUESTS
### Metric: `prometheus_exporter_requests_total`

**Description:**  
The **Total HTTP Requests Metric** records the **total number of HTTP requests** received by the Prometheus exporter. This metric is a **counter**, meaning it only increases over time, reflecting the cumulative number of requests processed since the exporter started running.  

Tracking this metric is essential for monitoring service demand, detecting unusual request spikes, and ensuring that the system can handle incoming traffic efficiently.

**Value Interpretation:**  
- **Each increment** in this counter represents a new processed request.
- **The absolute value** of this metric indicates the total number of requests since data collection started.

**Example Value:**  
- **Total Requests Received:** `4`

By monitoring this metric, operators can track system load, optimize resource allocation, and detect potential issues such as traffic surges or service disruptions.

## HTTP RESPONSE SIZE
### Metric: `prometheus_exporter_response_size_bytes`

**Description:**  
The **HTTP Response Size Metric** measures the size of the **HTTP response** generated by the Prometheus exporter, recorded in **bytes**. This metric is a **gauge**, meaning it can increase or decrease over time, reflecting changes in response payload size.  

Tracking this metric is important for optimizing resource usage, identifying unusually large responses, and ensuring efficient communication between Prometheus and its clients.

**Value Interpretation:**  
- **Higher values** may indicate that Prometheus is returning more data than usual, potentially leading to increased network and memory usage.
- **Consistently high values** may suggest the need for query optimization or data reduction.

**Example Value:**  
- **Current Response Size:** `37,821` bytes.

By monitoring this metric, system operators can detect inefficient queries, optimize response payloads, and maintain a well-performing Prometheus instance.

## BATCH PUT LATENCY
### Metric: `rockbound_batch_put_latency_seconds`

**Description:**  
The **Batch Put Latency Metric** measures the time taken for **batch put operations** in the Rockbound Schema, recorded in **seconds**. This metric is represented as a **histogram**, allowing detailed analysis of latency distribution across different time intervals.  

Monitoring batch put latency helps assess database performance, detect bottlenecks in data storage, and ensure that writes to the database remain efficient.

**Value Interpretation:**  
Each bucket represents the number of batch put operations completed within the specified latency threshold.

| Latency Threshold (`le`) | Operations Completed |
|-------------------------|----------------------|
| `≤ 0.001s`             | 1,013,076 operations |
| `≤ 0.002s`             | 1,013,078 operations |
| `≤ 0.004s`             | 1,013,079 operations |
| `≤ 0.008s`             | 1,013,079 operations |
| `≤ 0.016s`             | 1,013,079 operations |
| `≤ 0.032s`             | 1,013,079 operations |
| `≤ 0.064s`             | 1,013,079 operations |
| `≤ 0.128s`             | 1,013,079 operations |
| `≤ 0.256s`             | 1,013,079 operations |
| `≤ 0.512s`             | 1,013,079 operations |
| `≤ 1.024s`             | 1,013,079 operations |
| `≤ 2.048s`             | 1,013,079 operations |
| `≤ 4.096s`             | 1,013,079 operations |
| `≤ 8.192s`             | 1,013,079 operations |
| `≤ 16.384s`            | 1,013,079 operations |
| `≤ 32.768s`            | 1,013,079 operations |
| `≤ 65.536s`            | 1,013,079 operations |
| `≤ 131.072s`           | 1,013,079 operations |
| `≤ 262.144s`           | 1,013,079 operations |
| `≤ 524.288s`           | 1,013,079 operations |
| `+Inf`                 | 1,013,079 operations |

- **Total Processing Time:** `1.5866774699999884` seconds.  
- **Total Batch Put Operations Count:** `1,013,079`.  

By tracking this metric, system operators can identify slow write operations, optimize database performance, and ensure that the system efficiently handles batch data insertions.

## ROCKBOUND PUT DATA SIZE
### Metric: `rockbound_put_bytes`

**Description:**  
The **Rockbound Put Data Size Metric** measures the **size of data (in bytes)** written to different **Column Families (CFs)** in the Rockbound Schema. This metric is recorded as a **histogram**, allowing detailed analysis of the distribution of data sizes across different thresholds.

Tracking this metric is essential for optimizing database performance, monitoring write efficiency, and ensuring storage is used effectively.

**Value Interpretation:**  
Each bucket represents the number of data writes that fall within the specified size threshold for a given column family.

### **Finalized Slots**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 12,048 writes   |
| `+Inf`                    | 12,048 writes   |

- **Total Data Written:** `96,384 bytes`  
- **Total Write Operations:** `12,048`

---

### **Slot By Hash**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 12,048 writes   |

- **Total Data Written:** `481,920 bytes`  
- **Total Write Operations:** `12,048`

---

### **Slot By Rollup Height**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 12,048 writes   |

- **Total Data Written:** `1,542,144 bytes`  
- **Total Write Operations:** `12,048`

---

### **Kernel JMT Nodes**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 663,687 writes  |

- **Total Data Written:** `339,904,913 bytes`  
- **Total Write Operations:** `663,687`

---

### **Kernel JMT Values**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 120,480 writes  |

- **Total Data Written:** `11,397,408 bytes`  
- **Total Write Operations:** `120,480`

---

### **Kernel Key Hash to Key**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 120,480 writes  |

- **Total Data Written:** `9,963,696 bytes`  
- **Total Write Operations:** `120,480`

---

### **User JMT Nodes**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 48,192 writes   |

- **Total Data Written:** `14,216,640 bytes`  
- **Total Write Operations:** `48,192`

---

### **User JMT Values**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 12,048 writes   |

- **Total Data Written:** `783,120 bytes`  
- **Total Write Operations:** `12,048`

---

### **User Key Hash to Key**
| Data Size Threshold (`le`) | Number of Writes |
|---------------------------|------------------|
| `≤ 10 bytes`              | 0 writes        |
| `+Inf`                    | 12,048 writes   |

- **Total Data Written:** `915,648 bytes`  
- **Total Write Operations:** `12,048`

---

By tracking this metric, system operators can monitor database write performance, optimize storage allocation, and detect potential inefficiencies in data insertion processes.

## SCHEMADB BATCH COMMIT SIZE
### Metric: `schemadb_batch_commit_bytes`

**Description:**  
The **SchemaDB Batch Commit Size Metric** measures the total **size of batch commit operations (in bytes)** for different databases within SchemaDB. This metric is recorded as a **histogram**, enabling the analysis of batch commit size distribution across different thresholds.

Tracking this metric helps in evaluating database write efficiency, detecting anomalies in commit sizes, and optimizing storage performance.

**Value Interpretation:**  
Each bucket represents the number of batch commit operations that fall within a specific size range for a given database.

### **Accessory Database (`accessory-db`)**
| Batch Commit Size Threshold (`le`) | Number of Commits |
|-----------------------------------|------------------|
| `≤ 10 bytes`                      | 0 commits       |
| `+Inf`                             | 12,048 commits  |

- **Total Data Committed:** `144,576 bytes`  
- **Total Batch Commits:** `12,048`

---

### **Ledger Database (`ledger-db`)**
| Batch Commit Size Threshold (`le`) | Number of Commits |
|-----------------------------------|------------------|
| `≤ 10 bytes`                      | 0 commits       |
| `+Inf`                             | 12,048 commits  |

- **Total Data Committed:** `2,409,600 bytes`  
- **Total Batch Commits:** `12,048`

---

### **State Database (`state-db`)**
| Batch Commit Size Threshold (`le`) | Number of Commits |
|-----------------------------------|------------------|
| `≤ 10 bytes`                      | 0 commits       |
| `+Inf`                             | 12,048 commits  |

- **Total Data Committed:** `381,724,301 bytes`  
- **Total Batch Commits:** `12,048`

---

By monitoring this metric, system operators can evaluate the efficiency of batch commit operations across different databases, optimize storage usage, and detect potential anomalies in database writes.

## SCHEMADB BATCH COMMIT LATENCY
### Metric: `schemadb_batch_commit_latency_seconds`

**Description:**  
The **SchemaDB Batch Commit Latency Metric** measures the time taken for batch commit operations in **SchemaDB**, recorded in **seconds**. This metric is represented as a **histogram**, enabling a detailed analysis of commit latency across different time intervals.

Monitoring batch commit latency helps optimize database performance, identify slow write operations, and ensure efficient transaction processing.

**Value Interpretation:**  
Each bucket represents the number of batch commit operations completed within a given latency threshold for a specific database.

### **Accessory Database (`accessory-db`)**
| Latency Threshold (`le`) | Number of Commits |
|-------------------------|------------------|
| `≤ 0.001s`             | 11,967 commits  |
| `≤ 0.002s`             | 12,018 commits  |
| `≤ 0.004s`             | 12,040 commits  |
| `≤ 0.008s`             | 12,048 commits  |
| `+Inf`                 | 12,048 commits  |

- **Total Processing Time:** `3.5006` seconds  
- **Total Batch Commits:** `12,048`

---

### **Ledger Database (`ledger-db`)**
| Latency Threshold (`le`) | Number of Commits |
|-------------------------|------------------|
| `≤ 0.001s`             | 11,995 commits  |
| `≤ 0.002s`             | 12,030 commits  |
| `≤ 0.004s`             | 12,044 commits  |
| `≤ 0.008s`             | 12,047 commits  |
| `+Inf`                 | 12,048 commits  |

- **Total Processing Time:** `3.1032` seconds  
- **Total Batch Commits:** `12,048`

---

### **State Database (`state-db`)**
| Latency Threshold (`le`) | Number of Commits |
|-------------------------|------------------|
| `≤ 0.001s`             | 4,026 commits   |
| `≤ 0.002s`             | 11,870 commits  |
| `≤ 0.004s`             | 11,986 commits  |
| `≤ 0.008s`             | 12,041 commits  |
| `+Inf`                 | 12,048 commits  |

- **Total Processing Time:** `14.0101` seconds  
- **Total Batch Commits:** `12,048`

---

By tracking this metric, system administrators can identify performance bottlenecks in batch commit operations, optimize storage transactions, and ensure that commit latencies remain within acceptable limits.

## SCHEMADB GET DATA SIZE
### Metric: `schemadb_get_bytes`

**Description:**  
The **SchemaDB Get Data Size Metric** measures the **size of data (in bytes)** retrieved from different **Column Families (CFs)** in SchemaDB. This metric is recorded as a **histogram**, allowing analysis of the distribution of retrieved data sizes across different thresholds.

Monitoring this metric helps evaluate query efficiency, optimize database read operations, and identify potential inefficiencies in data retrieval.

**Value Interpretation:**  
Each bucket represents the number of data retrieval operations that fall within the specified size threshold for a given column family.

### **Finalized Slots**
| Data Size Threshold (`le`) | Number of Reads |
|---------------------------|----------------|
| `≤ 10 bytes`              | 1 read        |
| `+Inf`                    | 1 read        |

- **Total Data Retrieved:** `8 bytes`  
- **Total Read Operations:** `1`

---

### **Slot By Rollup Height**
| Data Size Threshold (`le`) | Number of Reads |
|---------------------------|----------------|
| `≤ 10 bytes`              | 0 reads       |
| `+Inf`                    | 12,048 reads  |

- **Total Data Retrieved:** `1,445,760 bytes`  
- **Total Read Operations:** `12,048`

---

### **Kernel JMT Nodes**
| Data Size Threshold (`le`) | Number of Reads |
|---------------------------|----------------|
| `≤ 10 bytes`              | 0 reads       |
| `+Inf`                    | 2,034,089 reads  |

- **Total Data Retrieved:** `1,090,706,478 bytes`  
- **Total Read Operations:** `2,034,089`

---

### **Kernel Key Hash to Key**
| Data Size Threshold (`le`) | Number of Reads |
|---------------------------|----------------|
| `≤ 10 bytes`              | 0 reads       |
| `+Inf`                    | 72,288 reads  |

- **Total Data Retrieved:** `3,325,248 bytes`  
- **Total Read Operations:** `72,288`

---

### **User JMT Nodes**
| Data Size Threshold (`le`) | Number of Reads |
|---------------------------|----------------|
| `≤ 10 bytes`              | 0 reads       |
| `+Inf`                    | 72,290 reads  |

- **Total Data Retrieved:** `24,145,778 bytes`  
- **Total Read Operations:** `72,290`

---

By tracking this metric, system administrators can monitor read performance, optimize database queries, and detect potential inefficiencies in data retrieval processes.

## SCHEMADB GET LATENCY
### Metric: `schemadb_get_latency_seconds`

**Description:**  
The **SchemaDB Get Latency Metric** measures the **time taken (in seconds)** for database read operations across different **Column Families (CFs)**. This metric is recorded as a **histogram**, allowing analysis of the distribution of read latencies across different thresholds.

Monitoring this metric helps optimize database performance by identifying potential bottlenecks and ensuring efficient query execution.

**Value Interpretation:**  
Each bucket represents the number of data retrieval operations that fall within the specified latency threshold for a given column family.

---

### **Finalized Slots**
| Latency Threshold (`le`) | Number of Reads |
|--------------------------|----------------|
| `≤ 0.000016s`           | 1 read        |
| `+Inf`                   | 1 read        |

- **Total Query Time:** `0.000013282 seconds`  
- **Total Read Operations:** `1`

---

### **Slot By Rollup Height**
| Latency Threshold (`le`) | Number of Reads |
|--------------------------|----------------|
| `≤ 0.000032s`           | 11,720 reads  |
| `≤ 0.000064s`           | 12,029 reads  |
| `+Inf`                   | 12,048 reads  |

- **Total Query Time:** `0.218449514 seconds`  
- **Total Read Operations:** `12,048`

---

### **Kernel JMT Nodes**
| Latency Threshold (`le`) | Number of Reads |
|--------------------------|----------------|
| `≤ 0.000008s`           | 1,191,864 reads |
| `≤ 0.000032s`           | 1,922,985 reads |
| `+Inf`                   | 2,034,089 reads |

- **Total Query Time:** `28.499756236 seconds`  
- **Total Read Operations:** `2,034,089`

---

### **Kernel Key Hash to Key**
| Latency Threshold (`le`) | Number of Reads |
|--------------------------|----------------|
| `≤ 0.000016s`           | 70,304 reads  |
| `≤ 0.000032s`           | 72,045 reads  |
| `+Inf`                   | 72,288 reads  |

- **Total Query Time:** `0.526733777 seconds`  
- **Total Read Operations:** `72,288`

---

### **User JMT Nodes**
| Latency Threshold (`le`) | Number of Reads |
|--------------------------|----------------|
| `≤ 0.000032s`           | 69,792 reads  |
| `≤ 0.000064s`           | 72,191 reads  |
| `+Inf`                   | 72,290 reads  |

- **Total Query Time:** `0.816024419 seconds`  
- **Total Read Operations:** `72,290`

---

By tracking this metric, system administrators can **optimize query execution**, reduce database response times, and maintain **high-performance data retrieval operations**.

## SCHEMADB ITERATION LATENCY
### Metric: `schemadb_iter_latency_seconds`

**Description:**  
The **SchemaDB Iteration Latency Metric** measures the **time taken (in seconds)** for database iteration operations across different **Column Families (CFs)**. This metric is recorded as a **histogram**, allowing analysis of the distribution of iteration latencies across different thresholds.

Monitoring this metric helps evaluate the efficiency of database iterators, which are crucial for **querying large datasets efficiently**.

**Value Interpretation:**  
Each bucket represents the number of database iteration operations that fall within the specified latency threshold for a given column family.

---

### **Accepted Transactions (AcceptedTxs)**
| Latency Threshold (`le`) | Number of Iterations |
|--------------------------|----------------------|
| `≤ 0.000001s`           | 1 iteration         |
| `+Inf`                   | 1 iteration         |

- **Total Iteration Time:** `0.000000805 seconds`  
- **Total Iteration Operations:** `1`

---

By tracking this metric, system administrators can **identify performance bottlenecks**, optimize **query execution**, and maintain a **high-performance database iteration process**.

