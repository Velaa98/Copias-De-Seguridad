#!/usr/bin/env bash

<<comment
# Nombre del fichero: CopiaDeSeguridad.bash
# Fecha de creación: 13/12/2018
# Autor: José Manuel Vela Fernández
# Versión: 0.1.0-Alpha
# Descripción del script: Realización y gestión automática de las copias de seguridad en Rajoy, Zapatero y Aznar.
comment

#. funciones.bash

# Lee los directorios de los que se va a realizar la copia.
read directorios < directorios.txt

# Día de la semana donde el lunes es 1 y el domingo 7.
DSEM=`date +%u`

# Fecha actual en formato DD/MM/YY
FechaActual=`date +%d-%m-%y`

# Directorios y formato para las copias de seguridad Ej: TipoDeCopia_FechaActual.Formato
CopiaCompleta="/backups/CC_$FechaActual.tgz"
CopiaDiferencial="/backups/CD_$FechaActual.tgz"
CopiaIncremental="/backups/CI_$FechaActual.tgz"

# Directorios y formato para las snaps.
SnapCompleta=/snapshots/Completa.snap
SnapDiferencial=/snapshots/Diferencial.snap
SnapIncremental=/snapshots/Incremental.snap


# Si es día 1 (Lunes), borra la snap de la semana anterior, crea una copia completa y su snap correspondiente, también crea la snap que se usará para las copias incrementales.
if [ $DSEM = 1 ];
then
	rm -f $SnapCompleta 2> /dev/null
	tar -caf $CopiaCompleta $directorios -g $SnapCompleta 2> /dev/null
	cp $SnapCompleta $SnapIncremental

# Si el día es 4 (Jueves), borra la snap difencial de la semana anterior, borra la incrimental respecto a la completa, copia la snap de la completa para crear una copia diferencial y su snap correspondiente, crea la snap para las incrementales respecto a la direncial actual.
elif [ $DSEM = 4 ];
then
	rm -f $SnapDiferencial 2> /dev/null
	rm -f $SnapIncremental 2> /dev/null
	cp $SnapCompleta $SnapDiferencial
	tar -caf $CopiaDiferencial $directorios -g $SnapDiferencial 2> /dev/null
	cp $SnapDiferencial $SnapIncremental

# Para el resto de días crea una copia incremental basada en la snap de la última incremental creada/modificada.
else
	tar -caf $CopiaIncremental $directorios -g $SnapIncremental 2> /dev/null
fi

# Si estamos en rajoy mueve la copia al volumen.
if [ `hostname` = rajoy ];
then
	# Directorio donde está montado el volumen.
	mv /backups/C?_`date +%d-%m-%y`.tgz /mnt/copias

# Si estamos en Zapatero o Aznar usa scp para mover la copia al volumen.
else
	scp /backups/C?_`date +%d-%m-%y`.tgz rajoy:/mnt/copias
fi