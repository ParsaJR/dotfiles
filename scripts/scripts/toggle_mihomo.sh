#!/bin/sh

# Simple script for toggling the mihomo (clash.meta) service.

SERVICE="mihomo.service"

if [ "$(systemctl is-active "$SERVICE")" = "active" ]; then
	sudo systemctl stop $SERVICE
else
	sudo systemctl start $SERVICE
fi

if [ $? -eq 0 ]; then
	notify-send done!	
fi
