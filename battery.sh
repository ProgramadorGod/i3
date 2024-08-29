#!/bin/bash

function charger_state_changed() {
    battery=$(acpi | awk '{print $4}' | tr -d ',')
    charge=$(acpi | awk '{print $4}' | tr -d '%,')
    charger=$(acpi -a | awk '{print $3}')
    if [ "$1" == "on-line" ]; then
        notify-send -t 700 "Charger connected" "Battery is at $battery" -u normal
    else
        notify-send -t 700 "Charger disconnected" "Battery is at $battery" -u critical
    fi
}

# Iniciar acpi_listen en segundo plano y guardar su PID
acpi_listen | while read event; do
    battery=$(acpi | awk '{print $4}' | tr -d ',')
    charge=$(acpi | awk '{print $4}' | tr -d '%,')
    charger=$(acpi -a | awk '{print $3}')   
    if echo $event | grep -q "ac_adapter"; then
        charger_state_changed $(acpi -a | awk '{print $3}')
    fi
done &
acpi_pid=$!

while true; do
    battery=$(acpi | awk '{print $4}' | tr -d ',')
    charge=$(acpi | awk '{print $4}' | tr -d '%,')
    charger=$(acpi -a | awk '{print $3}')
    
    if [ "$charger" != "on-line" ] && [ "$charge" -lt 15 ]; then
        notify-send -t 1000 "Charger disconnected" "Battery is at $battery remaining" -u critical
    fi
    
    sleep 3s
done

# Detener acpi_listen cuando el script se detiene
kill $acpi_pid
