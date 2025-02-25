#!/bin/bash

#Copiar los archivos del repositorio a la carpeta que sirve NGINX
sudo cp -r /home/devops/PaginaWeb_Devops/* /var/www/html

#Reiniciar nginx para aplicar los cambios
sudo systemctl restart nginx

echo "Archivos actualizados"
