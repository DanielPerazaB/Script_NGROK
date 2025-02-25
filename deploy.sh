#!/bin/bash

#Apagamos los servicios
echo "Deteniendo NGINX y NGROK"
sudo systemctl stop nginx
pkill ngrok

#Navegar al directorio de mi repo
REPO_DIR="/home/devops/PaginaWeb_Devops"
echo "Navegando al directorio del repositorio: $REPO_DIR"
cd $REPO_DIR || exit

#Obtenemos los ùltimos cambios del repo
echo "Actualizando repositorio..."
git pull origin master --rebase

#Encendemos NGINX
echo "Iniciando NGINX..."
sudo systemctl start nginx

#Iniciamos NGROK
echo "Iniciando NGROK.."
ngrok http 80 > ngrok.log &
sleep 5

#Se extrae la url pùblica de NGROK
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "La URL publica es: $NGROK_URL"

#Ejecutar el script de despliegue del repositorio
echo "Ejecutando script de despliegue..."
sh deploy.sh

echo "Despliegue completado. Accede al sitio en: $NGROK_URL"
