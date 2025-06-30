#!/bin/bash

# Script to extract custom Spicenet metrics from systemd logs and combine them with Prometheus exporter metrics.

# File paths
METRICS_FILE="/usr/local/metrics/spicenet_metrics.prom"
TEMP_FILE="/usr/local/metrics/spicenet_metrics_temp.prom"
EXPORTER_METRICS_ENDPOINT="http://localhost:9845/metrics"

# Function: extract a numeric value from a line using regex (default to 0 if empty)
sanitize_number() {
  local raw="$1"
  local clean=$(echo "$raw" | sed 's/[^0-9.]//g')
  [[ "$clean" =~ ^[0-9]+([.][0-9]+)?$ ]] && echo "$clean" || echo "0"
}

# Extract values from systemd logs
log_slot=$(journalctl -u spicenet -o cat -n 20000 | grep 'Saving changes after applying slot' | tail -1)
log_visible=$(journalctl -u spicenet -o cat -n 20000 | grep 'Setting next visible slot number' | tail -1)
log_exec=$(journalctl -u spicenet -o cat -n 20000 | grep 'Block execution complete time=' | tail -1)
log_blobs=$(journalctl -u spicenet -o cat -n 20000 | grep 'Extracted relevant blobs' | tail -1)
log_da=$(journalctl -u spicenet -o short-iso -n 20000 | grep 'next_da_height=' | tail -1)

# Extract metrics from logs
slot_number=$(echo "$log_slot" | sed -E 's/.*slot_number=([0-9]+).*/\1/')
slot_visible=$(echo "$log_visible" | sed -E 's/.*next_visible_slot_number=([0-9]+).*/\1/')
exec_time=$(echo "$log_exec" | sed -E 's/.*time=([0-9.]+)s.*/\1/')
blobs_count=$(echo "$log_blobs" | sed -E 's/.*batch_blobs_count=([0-9]+).*/\1/')
current_state_root=$(echo "$log_slot" | sed -E 's/.*current_state_root="([^"]+)".*/\1/')
next_state_root=$(echo "$log_slot" | sed -E 's/.*next_state_root="([^"]+)".*/\1/')
next_da_height=$(echo "$log_da" | grep -oP 'next_da_height=\K\d+')

# Sanitize numeric values
slot_number=$(sanitize_number "$slot_number")
slot_visible=$(sanitize_number "$slot_visible")
exec_time=$(sanitize_number "$exec_time")
blobs_count=$(sanitize_number "$blobs_count")
next_da_height=$(sanitize_number "$next_da_height")

# Write metrics to temporary file
> "$TEMP_FILE"

cat <<EOF >> "$TEMP_FILE"
# HELP spicenet_rollup_slot_number Last slot processed
# TYPE spicenet_rollup_slot_number gauge
spicenet_rollup_slot_number $slot_number

# HELP spicenet_rollup_slot_visible Last visible rollup slot
# TYPE spicenet_rollup_slot_visible gauge
spicenet_rollup_slot_visible $slot_visible

# HELP spicenet_rollup_blobs_count Number of blobs processed
# TYPE spicenet_rollup_blobs_count gauge
spicenet_rollup_blobs_count $blobs_count

# HELP spicenet_rollup_exec_time Execution time of last slot (seconds)
# TYPE spicenet_rollup_exec_time gauge
spicenet_rollup_exec_time $exec_time

# HELP spicenet_current_state_root Last state root (label)
# TYPE spicenet_current_state_root gauge
spicenet_current_state_root{hash="$current_state_root"} 1

# HELP spicenet_next_state_root Next state root (label)
# TYPE spicenet_next_state_root gauge
spicenet_next_state_root{hash="$next_state_root"} 1

# HELP spicenet_next_da_height Celestia DA block height processed
# TYPE spicenet_next_da_height gauge
spicenet_next_da_height $next_da_height
EOF

# Append metrics from Prometheus exporter
curl -s "$EXPORTER_METRICS_ENDPOINT" | grep -E '^(# HELP|# TYPE|prometheus_exporter_|rockbound_|schemadb_)' >> "$TEMP_FILE"

# Finalize
mv -f "$TEMP_FILE" "$METRICS_FILE"
chown node_exporter:node_exporter "$METRICS_FILE"
chmod 644 "$METRICS_FILE"

echo "✅ Spicenet metrics updated and combined with exporter metrics."

