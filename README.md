### Copias-De-Seguridad

Script para realizar copias de seguridad en los 3 servidores de clase durante el curso.

#### Versionado (P. ej: v0.1.0-Alpha)

mayor (0): el software sufre grandes cambios y mejoras.
menor (1): el software sufre pequeños cambios y/o correcciones de errores.
micro (0): se aplica una corrección al software, y a su vez sufre pocos cambios.
fase (Alpha): se indica si se encuentra en una fase de desarrollo que no sea la final o estable.


#### A solucionar

- Actualmente es necesario realizar la primera copia completa y/o diferencial según cuando empecemos a usar el script. O por otro lado, te obliga empezar a usar el script un lunes.


#### Siguiente versión

- [x] Cambiar el formato del fichero directorios.txt y usar getopts para recoger parámetros con los que listar, añadir o borrar lineas de dicho fichero. 
- [ ] Situar el script en el servidor principal (Rajoy) para realizar las copias desde ahí conectandose a los otros servidores mediante clave pública-privada.

#### Consideraciones

- Directorio para el script /usr/local/sbin.
- Directorio para las copias de seguridad /var/backups.
- Directorio para las snapshots /var/backups/snapshots.
