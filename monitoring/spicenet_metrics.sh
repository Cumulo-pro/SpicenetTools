#!/bin/bash

# Paths
METRICS_FILE="/usr/local/metrics/spicenet_metrics.prom"
TEMP_FILE="/usr/local/metrics/spicenet_metrics_temp.prom"
LOG_FILE="/var/log/spicenet.log"
EXPORTER_METRICS_ENDPOINT="http://localhost:9045/metrics"

# Helper: clean numbers
sanitize_number() {
  local raw="$1"
  local clean=$(echo "$raw" | sed 's/[^0-9.]//g' | sed -E 's/^0+([1-9])/\1/')
  [[ "$clean" =~ ^[0-9]+([.][0-9]+)?$ ]] && echo "$clean" || echo "0"
}

# Extract local metrics from logs
latest_rollup_height=$(sanitize_number "$(grep 'Setting next visible rollup height' "$LOG_FILE" | tail -1 | awk -F '=' '{print $NF}')")
last_finalized_height=$(sanitize_number "$(grep 'Got last finalized header' "$LOG_FILE" | tail -1 | awk -F '=' '{print $NF}')")
error_count=$(sanitize_number "$(grep -c 'ERROR' "$LOG_FILE")")

# Extract last block execution height and time, cleaning ANSI codes
last_execution_line=$(grep "Execution of block is completed" "$LOG_FILE" | tail -1 | sed 's/\x1b\[[0-9;]*m//g')

execution_block_raw=$(echo "$last_execution_line" | awk -F 'height=' '{print $2}' | awk '{print $1}')
execution_block=$(sanitize_number "$execution_block_raw")

execution_time_seconds=$(echo "$last_execution_line" | grep -oE 'time=[0-9.]+s' | sed 's/[^0-9.]//g')

# Start temp file
> "$TEMP_FILE"

# Write node metrics
cat <<EOF >> "$TEMP_FILE"
# HELP latest_rollup_height Latest rollup height in Spicenet
# TYPE latest_rollup_height gauge
latest_rollup_height $latest_rollup_height

# HELP last_finalized_height Last finalized block height in Spicenet
# TYPE last_finalized_height gauge
last_finalized_height $last_finalized_height

# HELP error_count Number of recent errors in Spicenet logs
# TYPE error_count gauge
error_count $error_count

# HELP execution_time_seconds Execution time of the last block (in seconds)
# TYPE execution_time_seconds gauge
execution_time_seconds $execution_time_seconds

# HELP execution_block Block height of the last completed execution
# TYPE execution_block gauge
execution_block $execution_block
EOF

# Append exporter metrics (filtered)
curl -s "$EXPORTER_METRICS_ENDPOINT" | grep -E '^(# HELP|# TYPE|prometheus_exporter_|rockbound_|schemadb_)' >> "$TEMP_FILE"

# Finalize
mv -f "$TEMP_FILE" "$METRICS_FILE"
chown node_exporter:node_exporter "$METRICS_FILE"
chmod 644 "$METRICS_FILE"

echo "✅ Spicenet metrics written and merged from logs and exporter."
