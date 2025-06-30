#!/bin/bash

# Paths
METRICS_DIR="/usr/local/metrics"
METRICS_FILE="$METRICS_DIR/spicenet_metrics.prom"
TEMP_FILE="$METRICS_DIR/spicenet_metrics_temp.prom"
SERVICE_NAME="spicenet"

# Create directory if missing
mkdir -p "$METRICS_DIR"

# Extract values using journalctl + sed
last_slot_number=$(sudo journalctl -u $SERVICE_NAME -o cat -n 10000 | grep 'Saving changes after applying slot' | tail -1 | sed -E 's/.*slot_number=([0-9]+).*/\1/')
last_visible_slot=$(sudo journalctl -u $SERVICE_NAME -o cat -n 10000 | grep 'Setting next visible slot number' | tail -1 | sed -E 's/.*next_visible_slot_number=([0-9]+).*/\1/')
blobs_processed=$(sudo journalctl -u $SERVICE_NAME -o cat -n 10000 | grep 'Extracted relevant blobs' | tail -1 | sed -E 's/.*batch_blobs_count=([0-9]+).*/\1/')
exec_time=$(sudo journalctl -u $SERVICE_NAME -o cat -n 20000 | grep 'execution complete' | tail -1 | sed -E 's/.*time=([0-9.]+)s.*/\1/')
current_state_root=$(sudo journalctl -u $SERVICE_NAME -o cat -n 10000 | grep 'Saving changes after applying slot' | tail -1 | sed -E 's/.*current_state_root="([^"]+)".*/\1/')
next_state_root=$(sudo journalctl -u $SERVICE_NAME -o cat -n 10000 | grep 'Saving changes after applying slot' | tail -1 | sed -E 's/.*next_state_root="([^"]+)".*/\1/')
next_da_height=$(sudo journalctl -u $SERVICE_NAME -o short-iso -n 20000 | grep 'next_da_height=' | tail -1 | grep -oP 'next_da_height=\K\d+')

# Escribir métricas al archivo temporal
cat <<EOF > "$TEMP_FILE"
# HELP spicenet_rollup_slot_number Último slot procesado
# TYPE spicenet_rollup_slot_number gauge
spicenet_rollup_slot_number $last_slot_number

# HELP spicenet_rollup_slot_visible Último slot visible
# TYPE spicenet_rollup_slot_visible gauge
spicenet_rollup_slot_visible $last_visible_slot

# HELP spicenet_rollup_blobs_count Número de blobs procesados
# TYPE spicenet_rollup_blobs_count gauge
spicenet_rollup_blobs_count $blobs_processed

# HELP spicenet_rollup_exec_time Tiempo de ejecución del bloque (s)
# TYPE spicenet_rollup_exec_time gauge
spicenet_rollup_exec_time $exec_time

# HELP spicenet_current_state_root Último state root actual
# TYPE spicenet_current_state_root gauge
spicenet_current_state_root{hash="$current_state_root"} 1

# HELP spicenet_next_state_root Siguiente state root esperado
# TYPE spicenet_next_state_root gauge
spicenet_next_state_root{hash="$next_state_root"} 1

# HELP spicenet_next_da_height Altura DA de Celestia procesada
# TYPE spicenet_next_da_height gauge
spicenet_next_da_height $next_da_height
EOF

# Guardar el archivo final
mv "$TEMP_FILE" "$METRICS_FILE"
chown node_exporter:node_exporter "$METRICS_FILE"
chmod 644 "$METRICS_FILE"
echo "✅ Spicenet metrics updated at $METRICS_FILE"
