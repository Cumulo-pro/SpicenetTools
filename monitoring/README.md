
## Introduction 

System for monitoring custom metrics for a Spicenet node using Prometheus and Node Exporter. Node Exporter is a powerful tool that collects operating system and hardware metrics from servers and can also be extended to expose custom metrics. Through this project, you will learn how to configure Node Exporter to collect and expose specific metrics from the Spicenet node, and how to automate this process using scripts and systemd services. This approach will provide you with detailed insights into the performance and status of the Spicenet node, facilitating efficient monitoring and maintenance of the system.

## Available Resources

- **[Install Spicenet Metrics](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/spicenet-monitoring/install_spicenet_metrics.md)**

  Implementation and Configuration of Custom Metrics Monitoring for Spicenet

- **[Spicenet Metrics FAQ](https://github.com/Cumulo-pro/SpicenetTools/blob/main/monitoring/metrics.md)**

  This document details the specific metrics available in Grafana for Spicenet nodes. It includes descriptions and explanations of various key metrics, such as latest rollup height, last finalized block height, execution time, and more.

- **[Grafana Dashboard JSON Configuration File]([https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/spicenet-monitoring/Spicenet%20Node.json](https://github.com/Cumulo-pro/SpicenetTools/blob/main/monitoring/Spicenet%20Node%20Monitoring%20by%20Cumulo-1739480931744.json))**

  This resource provides a JSON configuration file for a Grafana dashboard. The file includes all the necessary definitions and settings to visualize Spicenet node metrics in Grafana, making it easy to create informative panels and interactive graphs for real-time monitoring.

- **[Grafana Dashboard: Spicenet Node]()**

  System for monitoring custom metrics for a Spicenet node using Prometheus and Node Exporter. Node Exporter is a powerful tool that collects operating system and hardware metrics from servers and can also be extended to expose custom metrics.

- **[info_spicenet.sh](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/spicenet-monitoring/info_spicenet.sh)**

  Bash script designed to collect various metrics related to the Spicenet service and save this data in a metrics file in Prometheus format.



## Features

### Non-Intrusive Method

The implementation of these metrics does not require any modifications to the Spicenet node configuration. This ensures that the node continues to operate optimally without interruptions or changes to its original setup.

### Exclusive Use of Node Exporter

No additional applications or services are needed apart from **Node Exporter**, which should already be implemented to monitor server resources. This simplifies the setup and reduces administrative overhead.

### No Impact on Server Resources

The monitoring process does not alter the server resources dedicated to the Spicenet node. A simple script is used, which runs periodically via systemd and timers, ensuring that the server's performance is not affected.
  - Memory: 4.8 MB is low and typical for scripts of this type.
  - CPU: 1.202 seconds is an acceptable CPU usage for a periodic execution every 6 seconds.

### Simple and Quick Implementation

The implementation is extremely simple and quick. It only requires downloading a script and configuring systemd, which can be completed in a few minutes. This allows system administrators to set up metric monitoring without complications and with minimal time investment.

### Automated and Periodic Updates

The system is designed to update the metrics periodically and automatically using systemd services and timers. This ensures that up-to-date data is always available without continuous manual intervention.

With these features, this project provides an efficient and effective solution for monitoring custom metrics of the Spicenet node, leveraging the capabilities of Prometheus and Node Exporter to enhance the monitoring and maintenance of your infrastructure.

![image](https://github.com/user-attachments/assets/7e44f352-9156-4b86-b118-3142504dff10)
