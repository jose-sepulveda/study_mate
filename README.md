# Study Mate - Grupo 6

|Integrante| Rut | Rol
|--|--|--|
| Jose Sepulveda Gajardo | 20.563.679-K |Desarrollador Principal|
| Carlos Tapia González | 20.563.351-0 |Arquitectura de Software|
| Vicente Reyes Barrios | 20.564.697-3 |Encargado de Diseño|

 
## Caso de Uso

Study Mate permite a los usuarios crear recordatorios de eventos relacionados con sus estudios, aunque se da la posibilidad de que cualquier tipo de recordatorios sean creados, la aplicación se especializa en tareas relacionadas a la universidad, como por ejemplo: 
 - Pruebas
 - Tareas
 - Presentaciones
 - Otras actividades.
 
La caracteristica principal implementada es la **interaccion con el calendario del dispositivo.**

## Diseño
Study Meet fue diseñada con el objetivo de ser atractiva y facil de utilizar para el usuario, es por esto que la principal intención fue reducir la cantidad de pasos que se deben realizar para registrar recordatorios y visualizarlos.  Con esto en mente las pantallas de la aplicación presentan la menor cantidad de botones posible. Al finalizar el proceso de crear un recordatorio, el usuario podrá visualizarlo en un listado dentro de Study Mate y en la aplicación de calendarios de su dispositivo.

## Pantalla Inicial Study Mate
![enter image description here](https://i.imgur.com/ZVaYwE7.png?1)

En primer lugar el usuario se encuentra con un menu que contiene las categorias de los distintos recordatorios, cada uno de estos accederá a un listado unico con los recordatorios correspondientes a esa categoria.

![enter image description here](https://i.imgur.com/lclA1Hx.png?3)

Seguido a selececcionar una categoria el usuario será capaz de visualizar un listado con todos los recordatorios asociados a ella, tambien podrá eliminar, editar y agregar nuevos recordatorios desde el boton principal.

## Implementación

## Arquitectura

La arquitectura de software utilizada para implementar la aplicación Study Mate, fue un modelo de capas formado por Vistas, Controlladores y Servicios. 
La aplicación se compone de diversos widgets que se pueden considerar como Vista o Controllador, puesto que además de ofrecer funcionalidades con las cuales el usuario puede interactuar, estas presentan la interfaz de los distintos componentes. Teniendo esto en cuenta seccionamos los distintos controladores según las funciones de agregar, actualizar y eliminar los recordatorios presentes en los eventos registrados. 
![enter image description here](https://i.imgur.com/47sMeZn.png)
