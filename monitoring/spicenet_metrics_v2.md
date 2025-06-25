# 📈 Spicenet Node Metrics

This document provides a detailed list of the Prometheus metrics exposed by the Spicenet rollup node.

---

## 📊 General Prometheus Exporter Metrics

### `prometheus_exporter_request_duration_seconds`
**Description:** Histogram measuring the HTTP request latencies for the `/metrics` endpoint.

### `prometheus_exporter_requests_total`
**Description:** Counter for the number of times Prometheus has scraped the metrics endpoint.

---

## 🧠 Rockbound Storage Metrics

These metrics are histograms measuring the size of data written (`put_bytes`) and the latency of batch operations (`batch_put_latency_seconds`) by column family.

### `rockbound_batch_put_latency_seconds`
**Description:** Latency in seconds for batch put operations in the internal database.

### `rockbound_put_bytes{cf_name="BlobInfos"}`
**Description:** Bytes written for blob metadata.

### `rockbound_put_bytes{cf_name="Blobs"}`
**Description:** Bytes written for actual blob content.

### `rockbound_put_bytes{cf_name="FinalizedSlots"}`
**Description:** Bytes written to store finalized slot information.

### `rockbound_put_bytes{cf_name="ModuleAccessoryState"}`
**Description:** Data written by accessory modules of the kernel.

### `rockbound_put_bytes{cf_name="SlotByHash"}`
**Description:** Bytes written to map slots by their hash.

### `rockbound_put_bytes{cf_name="SlotByNumber"}`
**Description:** Bytes written to index slots by slot number.

---

## 🌱 Jellyfish Merkle Tree (JMT) State Metrics

### `rockbound_put_bytes{cf_name="kernel_jmt_nodes"}`
**Description:** Internal nodes written for the kernel's JMT.

### `rockbound_put_bytes{cf_name="kernel_jmt_values"}`
**Description:** Values written for the kernel's JMT.

### `rockbound_put_bytes{cf_name="kernel_key_hash_to_key"}`
**Description:** Reverse mapping from key hash to original key in the kernel.

### `rockbound_put_bytes{cf_name="user_jmt_nodes"}`
**Description:** User-level state nodes written in the modular JMT.

### `rockbound_put_bytes{cf_name="user_jmt_values"}`
**Description:** User-level state values written in the modular JMT.

---

## 📡 Access

Metrics are available at:

```
https://metrics.spicenet-node.cumulo.me/metrics
```

To configure Prometheus to scrape these metrics, add the following block:

```yaml
scrape_configs:
  - job_name: 'spicenet'
    static_configs:
      - targets: ['metrics.spicenet-node.cumulo.me']
```
