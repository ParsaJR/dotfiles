#!/bin/sh

# Simple script for toggling the mihomo (clash.meta) service.

# Suppose we have the systemd service already setup for the service:
SERVICE="mihomo.service"

if [ "$(systemctl is-active "$SERVICE")" = "active" ]; then
	sudo systemctl stop $SERVICE
	notify-send "mihomo stopped."	
else
	sudo systemctl start $SERVICE
	notify-send "mihomo started."	
fi

