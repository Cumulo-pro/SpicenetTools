#!/bin/bash

METRICS_FILE="/usr/local/metrics/spicenet_metrics.prom"
TEMP_FILE="/usr/local/metrics/spicenet_metrics_temp.prom"
UNIT_NAME="spicenet"

# Comando base para journalctl
JOURNAL="sudo journalctl -u $UNIT_NAME -o cat -n 20000"

# Extraer valores
slot_number=$( $JOURNAL | grep 'Saving changes after applying slot' | tail -1 | sed -E 's/.*slot_number=([0-9]+).*/\1/' )
visible_slot=$( $JOURNAL | grep 'Setting next visible slot number' | tail -1 | sed -E 's/.*next_visible_slot_number=([0-9]+).*/\1/' )
exec_time=$( $JOURNAL | grep 'Block execution complete time=' | tail -1 | sed -E 's/.*time=([0-9.]+)s.*/\1/' )
blob_count=$( $JOURNAL | grep 'Extracted relevant blobs' | tail -1 | sed -E 's/.*batch_blobs_count=([0-9]+).*/\1/' )
current_root=$( $JOURNAL | grep 'Saving changes after applying slot' | tail -1 | sed -E 's/.*current_state_root="([^"]+)".*/\1/' )
next_root=$( $JOURNAL | grep 'Saving changes after applying slot' | tail -1 | sed -E 's/.*next_state_root="([^"]+)".*/\1/' )
da_height=$( $JOURNAL | grep 'next_da_height=' | tail -1 | grep -oP 'next_da_height=\K\d+' )

# Escribir métricas
cat <<EOF > "$TEMP_FILE"
# HELP spicenet_rollup_slot_number Último slot procesado
# TYPE spicenet_rollup_slot_number gauge
spicenet_rollup_slot_number ${slot_number:-0}

# HELP spicenet_rollup_slot_visible Último slot visible
# TYPE spicenet_rollup_slot_visible gauge
spicenet_rollup_slot_visible ${visible_slot:-0}

# HELP spicenet_rollup_blobs_count Número de blobs procesados
# TYPE spicenet_rollup_blobs_count gauge
spicenet_rollup_blobs_count ${blob_count:-0}

# HELP spicenet_rollup_exec_time Tiempo de ejecución del bloque (s)
# TYPE spicenet_rollup_exec_time gauge
spicenet_rollup_exec_time ${exec_time:-0}

# HELP spicenet_current_state_root Último state root actual
# TYPE spicenet_current_state_root gauge
spicenet_current_state_root{hash="${current_root:-unknown}"} 1

# HELP spicenet_next_state_root Siguiente state root esperado
# TYPE spicenet_next_state_root gauge
spicenet_next_state_root{hash="${next_root:-unknown}"} 1

# HELP spicenet_next_da_height Altura DA de Celestia procesada
# TYPE spicenet_next_da_height gauge
spicenet_next_da_height ${da_height:-0}
EOF

# Mover y aplicar permisos
mv -f "$TEMP_FILE" "$METRICS_FILE"
chown node_exporter:node_exporter "$METRICS_FILE"
chmod 644 "$METRICS_FILE"

echo "✅ Spicenet metrics properly updated."


