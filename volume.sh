#!/bin/bash

# Obtener el volumen actual
#!/bin/bash

# Obtener el volumen actual


volume=$(amixer -D pulse get Master | awk -F'[][]' '/Right:/{print $2}')

# Mostrar la notificación
notify-send -t 700 "Volumen:" "$volume"