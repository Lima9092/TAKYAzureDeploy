#!/bin/bash

# Update and install required packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y openjdk-11-jre-headless unzip wget

# Download and install TAKY server
TAKY_ZIP_URL="https://tak-server-example.com/downloads/taky-server.zip"  # Replace with the actual URL
TAKY_INSTALL_DIR="/opt/taky-server"
wget $TAKY_ZIP_URL -O taky-server.zip
sudo unzip taky-server.zip -d $TAKY_INSTALL_DIR
sudo chmod +x $TAKY_INSTALL_DIR/start-taky.sh

# Create systemd service
SERVICE_FILE="/etc/systemd/system/taky.service"
echo -e '[Unit]
Description=TAKY Server
After=network.target

[Service]
User=azureuser
ExecStart='$TAKY_INSTALL_DIR'/start-taky.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target' | sudo tee $SERVICE_FILE

# Enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable taky
sudo systemctl start taky
