# ProjectX: Gestión de Permisos y Respaldo Automatizado

Este proyecto tiene como objetivo implementar un sistema de gestión de permisos y respaldo automatizado en un entorno Linux, específicamente en Linux Mint. El sistema está diseñado para ser escalable, seguro y fácil de mantener, y está optimizado para ser subido a GitHub.

## Tabla de Contenidos
- [Descripción del Proyecto](#descripción-del-proyecto)
- [Estructura del Repositorio](#estructura-del-repositorio)
- [Gestión de Usuarios y Permisos](#gestión-de-usuarios-y-permisos)
- [Configuración de ACLs](#configuración-de-acls)
- [Respaldo Automatizado](#respaldo-automatizado)
- [Automatización con Cron](#automatización-con-cron)
- [Pruebas y Verificación](#pruebas-y-verificación)
- [Contribución](#contribución)
- [Licencia](#licencia)

## Descripción del Proyecto
El proyecto **ProjectX** se centra en la gestión de permisos y la automatización de respaldos en un entorno Linux. Está diseñado para:

- Gestionar usuarios y grupos con diferentes niveles de acceso.
- Configurar permisos detallados utilizando ACLs (Access Control Lists).
- Automatizar respaldos de configuraciones críticas utilizando `rsync` y `cron`.
- Garantizar la seguridad y eficiencia en la administración del sistema.

## Estructura del Repositorio
```
projectX/
├── backup/                  # Directorio de respaldos automáticos
├── configuraciones/         # Archivos de configuración críticos
├── monitoreo/               # Directorio para el personal de soporte
├── repositorios/            # Directorio para desarrolladores
├── backup.sh                # Script de respaldo automatizado
├── README.md                # Documentación del proyecto
└── backup.log               # Registro de respaldos realizados
```

## Gestión de Usuarios y Permisos
Se han creado usuarios y grupos para gestionar los permisos de acceso a los directorios del proyecto:

**Grupos:**
- **dev**: Desarrolladores (acceso a `/repositorios`).
- **admins**: Administradores (acceso total a `/configuraciones`).
- **soporte**: Personal de soporte (acceso limitado a `/monitoreo`).

**Permisos:**
```bash
sudo chown root:dev /home/daniel/projectX/repositorios
sudo chmod 770 /home/daniel/projectX/repositorios
```

## Configuración de ACLs
Para permisos más detallados, se configuraron ACLs (Access Control Lists).

**Permisos para Desarrolladores:**
```bash
sudo setfacl -m u:devuser1:rwx /home/daniel/projectX/repositorios
```

**Permisos para Administradores:**
```bash
sudo setfacl -m g:admins:r-- /home/daniel/projectX/configuraciones/db_config.conf
```

## Respaldo Automatizado
Se implementó un sistema de respaldo automatizado utilizando `rsync` y `cron`. El script `backup.sh` realiza copias de seguridad diarias de los archivos de configuración críticos.

**Script de Respaldo (`backup.sh`)**
```bash
#!/bin/bash
# Script de respaldo de configuraciones

# Directorio de origen (configuraciones)
ORIGEN="/home/daniel/projectX/configuraciones/"

# Directorio de destino (respaldo)
DESTINO="/home/daniel/projectX/backup/configuraciones_$(date +%F)/"

# Crear el directorio de respaldo si no existe
mkdir -p "$DESTINO"

# Sincronizar los archivos de origen al destino
rsync -av --delete "$ORIGEN" "$DESTINO"

# Registrar la fecha del respaldo
echo "Respaldo completado el $(date)" >> /home/daniel/projectX/backup/backup.log
```

## Automatización con Cron
El script de respaldo se ejecuta automáticamente todos los días a las 2 AM utilizando `cron`.

**Configuración de Cron:**
1. Editar el archivo `crontab`:
```bash
crontab -e
```
2. Añadir la siguiente línea:
```bash
0 2 * * * /home/daniel/projectX/backup.sh
```
3. Verificar la tarea programada:
```bash
crontab -l
```

## Pruebas y Verificación
Para garantizar que el sistema funciona correctamente, se realizaron las siguientes pruebas:

**Ejecución Manual del Script:**
```bash
/home/daniel/projectX/backup.sh
```

**Verificación del Respaldo:**
```bash
ls /home/daniel/projectX/backup/configuraciones_$(date +%F)/
```

**Revisión del Archivo de Log:**
```bash
cat /home/daniel/projectX/backup/backup.log
```

## Contribución
Si deseas contribuir a este proyecto, sigue estos pasos:

1. Clona el repositorio:
```bash
git clone https://github.com/tu_usuario/projectX.git
```

2. Crea una rama para tu contribución:
```bash
git checkout -b nombre-de-tu-rama
```

3. Realiza tus cambios y haz un commit:
```bash
git add .
git commit -m "Descripción de tus cambios"
```

4. Sube tus cambios a GitHub:
```bash
git push origin nombre-de-tu-rama
```

5. Abre un **Pull Request** en GitHub.

## Licencia
Este proyecto está bajo la licencia MIT. Para más información, consulta el archivo `LICENSE`.


