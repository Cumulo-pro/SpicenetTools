E#!/bin/bash

# Paths
METRICS_FILE="/usr/local/metrics/spicenet_metrics.prom"
TEMP_FILE="/usr/local/metrics/spicenet_metrics_temp.prom"
LOG_FILE="/var/log/spicenet.log"
EXPORTER_METRICS_ENDPOINT="http://localhost:9045/metrics"

# Helper: clean numbers
sanitize_number() {
  local raw="$1"
  local clean=$(echo "$raw" | sed 's/[^0-9.]//g' | sed -E 's/^0+([1-9])?/\1/')
  [[ "$clean" =~ ^[0-9]+([.][0-9]+)?$ ]] && echo "$clean" || echo "0"
}

# Extract metrics using new log format
last_visible_slot=$(sanitize_number "$(grep 'Setting next visible slot number' "$LOG_FILE" | tail -1 | grep -oP 'next_visible_slot_number=\K\d+')")
last_slot_number=$(sanitize_number "$(grep 'Saving changes after applying slot' "$LOG_FILE" | tail -1 | grep -oP 'slot_number=\K\d+')")
current_state_root=$(grep 'Saving changes after applying slot' "$LOG_FILE" | tail -1 | grep -oP 'current_state_root="\K[^"]+')
next_state_root=$(grep 'Saving changes after applying slot' "$LOG_FILE" | tail -1 | grep -oP 'next_state_root="\K[^"]+')
blobs_processed=$(sanitize_number "$(grep 'Extracted relevant blobs' "$LOG_FILE" | tail -1 | grep -oP 'batch_blobs_count=\K\d+')")
execution_time_seconds=$(grep 'Block execution complete time=' "$LOG_FILE" | tail -1 | grep -oP 'time=\K[0-9.]+')

# Start temp file
> "$TEMP_FILE"

# Write node metrics
cat <<EOF >> "$TEMP_FILE"
# HELP spicenet_rollup_slot_visible Latest visible rollup slot number
# TYPE spicenet_rollup_slot_visible gauge
spicenet_rollup_slot_visible $last_visible_slot

# HELP spicenet_rollup_slot_number Last slot number processed
# TYPE spicenet_rollup_slot_number gauge
spicenet_rollup_slot_number $last_slot_number

# HELP spicenet_rollup_blobs_count Number of blobs processed in last block
# TYPE spicenet_rollup_blobs_count gauge
spicenet_rollup_blobs_count $blobs_processed

# HELP spicenet_rollup_exec_time Execution time of last slot in seconds
# TYPE spicenet_rollup_exec_time gauge
spicenet_rollup_exec_time $execution_time_seconds
EOF

# Append exporter metrics (filtered)
curl -s "$EXPORTER_METRICS_ENDPOINT" | grep -E '^(# HELP|# TYPE|prometheus_exporter_|rockbound_|schemadb_)' >> "$TEMP_FILE"

# Finalize
mv -f "$TEMP_FILE" "$METRICS_FILE"
chown node_exporter:node_exporter "$METRICS_FILE"
chmod 644 "$METRICS_FILE"

echo "✅ Spicenet metrics updated using new log format and merged from exporter."

