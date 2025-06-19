#!/bin/bash

# Detecta a interface ativa (com IP atribuído)
INTERFACE=$(ip route get 1.1.1.1 | awk '{print $5; exit}')
IP=$(ip -o -4 addr show $INTERFACE | awk '{print $4}' | cut -d/ -f1)

# Verifica se é Wi-Fi ou cabeada
if [[ $INTERFACE == wl* ]]; then
  # Interface Wi-Fi
  SSID=$(iwgetid -r)
  echo "󰖩  $SSID ($IP)"
else
  # Interface cabeada
  echo "󰈀  $INTERFACE ($IP)"
fi
