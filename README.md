# 		**Kinedu Test**

- Este proyecto corre sonbre contenedores de Docker
- Corre bajo la version de Ruby 2.6.0 y Rails 5.2.4
- realizar el clone del proyecto.
- Se requiere que se tenga instalado docker y docker-compose
  - Docker linux: https://docs.docker.com/engine/install/debian/
  - Docker Mac: https://docs.docker.com/docker-for-mac/install/
  - Docker-compose: https://docs.docker.com/compose/install/ 



## Inicio

Dentro del proyecto de kinedu hay un carpeta llamada docker, la cual contiene un script en bash con el cual se podra ejecutar todo. Teniendo un equipo con OS MacOS o Linux, usuand la terminal posicionarse sobre la carpeta de docker.



Lo primiero a ejecutar seria: ./app help

Help: app <help|build|delete|new|start|stop|restart|download>

```bash
   app help                         Show the current use of the script
   app build                        Build docker image RoR
   app delete                       Delete docker image  RoR
   app new                          Create new project of RoR
   app start                        Start containers of kinedu project
   app stop                         Delete containers of kinedu project
   app download                     Download docker image mysql 5.7
```
Ya que se tiene docker instalado, hay que crear la imagen RoR y descargar la imagen de mysql

1- ./app download   - para descargar la imagen de mysql que se ocupa para el proyecto

2- ./app build    -  Se va crear una imagen de docker local con lo necesario para ejecutar RoR

Una vez que se haya finalizado con estos pasos solo hay que hacer un paso mas

3 - ./app start -  Esto para inicializar los contenedores de docker basados en las imágenes, podran ver como se crean los contenedores y se muestra el log de los contenedores, por una lado mysql y tambien el server de rails, tarda poco solo en lo que descargar algunas gemas. podran acceder a la url de http://localhost:3001 y podran ver el proyecto.



Nota: El proyecto esta configurado para que se levante mysql y se importe el sql con los datos proporcionados, asi como los accesos a la base de datos se importan a los contenedores, los accesos estan un archivo .env que importa como variables de entorno a los contenedores.

