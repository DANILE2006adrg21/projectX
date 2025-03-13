k#!/bin/bash
# Script de respaldo de configuraciones

# Directorio de origen (configuraciones)
ORIGEN="/home/daniel/projectX/configuraciones/"
echo "Directorio de origen: $ORIGEN"

# Directorio de destino (respaldo)
DESTINO="/home/daniel/projectX/backup/configuraciones_$(date +%F)/"
echo "Directorio de destino: $DESTINO"

# Crear el directorio de respaldo si no existe
mkdir -p "$DESTINO"
if [ $? -eq 0 ]; then
    echo "Directorio de respaldo creado: $DESTINO"
else
    echo "Error: No se pudo crear el directorio de respaldo."
    exit 1
fi

# Sincronizar los archivos de origen al destino
rsync -av --delete "$ORIGEN" "$DESTINO"
if [ $? -eq 0 ]; then
    echo "Respaldo completado correctamente."
else
    echo "Error: No se pudo completar el respaldo."
    exit 1
fi

# Registrar la fecha del respaldo
echo "Respaldo completado el $(date)" >> /home/daniel/projectX/backup/backup.log
echo "Respaldo registrado en el log."
