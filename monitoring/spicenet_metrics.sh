#!/bin/bash

# Path to the Spicenet metrics file
metrics_file="/usr/local/metrics/spicenet_metrics.prom"
# Path to the temporary file
temp_metrics_file="/usr/local/metrics/spicenet_metrics_temp.prom"

# Clear the temporary metrics file
> "$temp_metrics_file"

# Get the latest visible rollup height
latest_rollup_height=$(grep "Setting next visible rollup height" /var/log/spicenet.log | tail -1 | awk '{print $NF}' | cut -d'=' -f2)
if [ -z "$latest_rollup_height" ]; then
    latest_rollup_height=0
fi

# Get the last finalized block height
last_finalized_height=$(grep "Got last finalized header" /var/log/spicenet.log | tail -1 | awk '{print $NF}' | cut -d'=' -f2)
if [ -z "$last_finalized_height" ]; then
    last_finalized_height=0
fi

# Count recent errors
error_count=$(grep -c "ERROR" /var/log/spicenet.log)
if [ -z "$error_count" ]; then
    error_count=0
fi

# Get the execution time and convert it to a floating point number (remove 's')
execution_time_raw=$(grep "Execution of block is completed" /var/log/spicenet.log | tail -1 | awk '{print $NF}' | cut -d'=' -f2)
execution_time=$(echo $execution_time_raw | sed 's/s//')  # Remove the 's' suffix and convert to float
execution_time=$(echo "$execution_time" | sed 's/\x1b\[[0-9;]*m//g')  # Remove control characters
if [ -z "$execution_time" ]; then
    execution_time=0
fi

# Get the execution block height
execution_block=$(grep "Execution of block is completed" /var/log/spicenet.log | tail -1 | sed 's/\x1b\[[0-9;]*m//g' | grep -o 'height=[0-9]*' | cut -d'=' -f2)
if [ -z "$execution_block" ]; then
    execution_block=0
fi

# Remove ANSI color characters from values before writing to the file
latest_rollup_height=$(echo "$latest_rollup_height" | sed 's/\x1b\[[0-9;]*m//g')
last_finalized_height=$(echo "$last_finalized_height" | sed 's/\x1b\[[0-9;]*m//g')
execution_block=$(echo "$execution_block" | sed 's/\x1b\[[0-9;]*m//g')

# Write to the temporary metrics file
{
    echo "# HELP latest_rollup_height Latest rollup height in Spicenet"
    echo "# TYPE latest_rollup_height gauge"
    echo "latest_rollup_height $latest_rollup_height"

    echo "# HELP last_finalized_height Last finalized block height in Spicenet"
    echo "# TYPE last_finalized_height gauge"
    echo "last_finalized_height $last_finalized_height"

    echo "# HELP error_count Number of recent errors in Spicenet logs"
    echo "# TYPE error_count gauge"
    echo "error_count $error_count"

    # Add the new metric for execution time
    echo "# HELP execution_time Execution time of the last block"
    echo "# TYPE execution_time gauge"
    echo "execution_time $execution_time"

    # Add the new metric for execution block (height)
    echo "# HELP execution_block Block height of the last completed execution"
    echo "# TYPE execution_block gauge"
    echo "execution_block $execution_block"
} > "$temp_metrics_file"

# Move the temporary file to the final file
mv "$temp_metrics_file" "$metrics_file"

echo "Spicenet metrics updated successfully."
