#!/bin/bash

echo "------------------------------"
echo "Starting Script"
echo "------------------------------"
echo "------------------------------"
echo "Installing and setting up Hostapd"
echo "------------------------------"
# Install hostapd--------------------
apt install hostapd
# Enable the wireless access point service and set it to start when your Raspberry Pi boots.
systemctl unmask hostapd
systemctl enable hostapd
#-----------------------------------

echo "------------------------------"
echo "Setup the Network Bridge"
echo "------------------------------"
# Add a bridge network device
cat bridge-br0.netdev > /etc/systemd/network/bridge-br0.netdev
# Add the built-in Ethernet interface (eth0) as a bridge member
cat br0-member-eth0.network > /etc/systemd/network/br0-member-eth0.network

echo "------------------------------"
echo "Enabling the systemd-networkd service"
echo "------------------------------"
systemctl enable systemd-networkd

echo "------------------------------"
echo "Define the bridge device IP configuration"
echo "------------------------------"
# DHCP Config
cat dhcpcd.conf >/etc/dhcpcd.conf

echo "------------------------------"
echo "Ensure Wireless Operation"
echo "------------------------------"
# To ensure WiFi radio is not blocked
rfkill unblock wlan

echo "------------------------------"
echo "Configure the AP Software"
echo "------------------------------"
# hostapd configuration file
cat hostapd.conf > /etc/hostapd/hostapd.conf
#-----------------------------------
echo "------------------------------"
echo "Completed. Hurray !"
echo "------------------------------"
echo "------------------------------"
echo "Reboot Once to apply settings"
echo "------------------------------"
