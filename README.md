# 		**Kinedu Test**

- Este proyecto corre sobre contenedores de Docker
- Corre bajo la version de Ruby 2.6.0 y Rails 5.2.4
- realizar el clone del proyecto.
- Se requiere que se tenga instalado docker y docker-compose
  - Docker linux: https://docs.docker.com/engine/install/debian/
  - Docker Mac: https://docs.docker.com/docker-for-mac/install/
  - Docker-compose: https://docs.docker.com/compose/install/ 



## Inicio

Dentro del proyecto de kinedu hay un carpeta llamada docker, la cual contiene un script en bash con el cual se podra ejecutar todo. Teniendo un equipo con OS MacOS o Linux, usando la terminal, posicionarse sobre la carpeta de docker.



Lo primiero a ejecutar seria: ./app help

Help: app <help|build|delete|new|start|stop|restart|download|get_tokens>

```bash
   app help                         Show the current use of the script
   app build                        Build docker image RoR
   app delete                       Delete docker image  RoR
   app new                          Create new project of RoR
   app start                        Start containers of kinedu project
   app stop                         Delete containers of kinedu project
   app download                     Download docker image mysql 5.7
   app get_tokens                   Create token for use api rest
```
Ya que se tiene docker instalado, hay que crear la imagen RoR y descargar la imagen de mysql

1- ./app download   - para descargar la imagen de mysql que se ocupa para el proyecto

2- ./app build    -  Se va crear una imagen de docker local con lo necesario para ejecutar RoR

Una vez que se haya finalizado con estos pasos solo hay que hacer un paso mas

3 - ./app start -  Esto para inicializar los contenedores de docker basados en las imágenes, podran ver como se crean los contenedores y se muestra el log de los contenedores, por una lado mysql y tambien el server de rails, tarda poco solo en lo que descarga algunas gemas. Podran acceder a la url de http://localhost:3001 y podran ver el proyecto.



## API

Para poder empezar a usar el api, primero hay que generar un token con el cual podran consumir los end points, para eso haremos lo siguiente:

./app get_tokens  - Esto generara un token y lo imprimira para que puedan usarlo

El token se debe enviar en un Header llamado: X-USER-TOKEN

Los endpoints disponibles son los siguientes:

GET http://localhost:3001/api/babies

GET http://localhost:3001/api/activities

GET http://localhost:3001/api/babies/:id/activity_logs

POST http://localhost:3001/api/activity_logs

{
	"baby_id": [id],
	"assistant_id": [id],
	"activity_id": [id]
}



PUT http://localhost:3001/api/activity_logs/:id

{
	"comments": "Terminado"
}

Nota: El proyecto esta configurado para que se levante mysql y se importe el sql con los datos proporcionados, asi como los accesos a la base de datos se importan a los contenedores, los accesos estan un archivo .env que importa como variables de entorno a los contenedores.

