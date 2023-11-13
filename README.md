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

 import  'package:flutter/material.dart';
    import  'package:study_mate/views/pruebas/prueba_list.dart';
    import  'package:study_mate/views/presentacion/presentacion_list.dart';
    import  'package:study_mate/views/tareas/tarea_list.dart';
    import  'package:study_mate/views/otros/otro_list.dart';

El extracto de código visto anteriormente representa las    importaciones de las vistas que contendrán las listas de cada evento    creado o actualizado distribuido en cada opción y que ademas estarán    ya ingresados dentro del calendario del dispositivo móvil.

    void _submitForm() async {
	    final  CalendarEvent event =  CalendarEvent(
		    title:  "PB "  + titleController.text,
		    description: descriptionController.text,
		    location: locationController.text,
		    startDate: startDate,
		    endDate: startDate.add(const  Duration(hours:  1)),
	    );
	    final maxIdCalendar =  await _getCalendar();
	    if (maxIdCalendar ==  null) {
		    print('No se encontró un calendario con la ID máxima');
		    return  null;
	    }	    
	    await _myPlugin.createEvent(calendarId: maxIdCalendar, event: event);
	    }
    }
    
El fragmento de código proporcionado anteriormente representa a la funcion de crear un evento dentro del calendario, donde se tomaran en cuenta los controladores definidos con anterioridad dentro del código, dichos controladores serán los datos que irán en los respectivos campos dentro del formulario que se mostrara para hacer ingreso del evento. Para dicha creacion se utilizara una funcion incluida en `_myPlugin` que es parte del widget `manage_calendar_events`

    void _updateEvent() async {    
	    final maxIdCalendar =  await _getCalendar();    
	    final  CalendarEvent event_upgrade =  CalendarEvent(    
		    eventId: idController.text,    
		    title: titleController.text,    
		    description: descriptionController.text,    
		    location: locationController.text,    
		    startDate: startDate,
		    endDate: startDate.add(const  Duration(hours:  1)),    
	    );    
	    _myPlugin    
			    .updateEvent(calendarId: maxIdCalendar, event: event_upgrade)    
			    .then((idController) {
		    debugPrint('${event_upgrade.eventId} is updated to $idController');
	    });
    }
    
La función anterior muestra la implementación de una actualización de algún evento ya creado, donde se toma en cuenta el id de dicho evento para que mediante la función `updateEvent` de `_myPlugin` se puedan actualizar los campos modificados dentro de un nuevo formulario para la actualización previa. Ademas previamente se definen la información que poseían originalmente los campos antes de ser modificados, dicha información ya será vista dentro del formulario.

    void _deleteEvent(String eventId) async {    
	    final maxIdCalendar =  await _getCalendar();    
	    _myPlugin    
			    .deleteEvent(calendarId: maxIdCalendar, eventId: eventId)    
			    .then((isDeleted) {    
		    debugPrint('Is Event deleted: $isDeleted');    
	    });    
    }
La función visualizada anteriormente representa la eliminacion de algún elemento ya creado, donde se considera la id del evento, ya que se eliminara el evento segun su id, esto se hará mediante la funcion `deleteEvent` incluido por `_myPlugin`.

    Future<List<CalendarEvent>?> _fetchEventsFromMaxIdCalendar() async {    
	    try {    
		    final hasPermissions =  await _myPlugin.hasPermissions();    
		    if (!hasPermissions!) {    
			    await _myPlugin.requestPermissions();    
		    }    
		    final calendars =  await _myPlugin.getCalendars();    
		    if (calendars ==  null  || calendars.isEmpty) {    
			    print('No se encontraron calendarios');    
			    return  null;    
		    }    
		    final maxIdCalendar =  await _getCalendar();    
		    if (maxIdCalendar ==  null) {    
			    print('No se encontró un calendario con la ID máxima');    
			    return  null;    
		    }    
		    final allEvents =  await _myPlugin.getEvents(calendarId: maxIdCalendar);    
		    final filteredEvents = allEvents    
			    ?.where((event) => event.title?.contains('PB') ??  false)    
			    .toList();
	              
		    return filteredEvents;    
	    } catch (e) {    
		    print('Error al obtener los eventos del calendario con la ID máxima: $e');    
		    return  null;    
	    }    
    }
La función anterior representa la selección de todos los eventos que están creados dentro de un calendario, dicha selección se hará mediante la funcion `getEvents` de `_myPlugin`, ademas se realizara un filtro para solo mostrar los eventos dentro de su respectiva funcion:
| Sigla | Opción | 
|--------------|--------------|
| PB | Prueba | 
| TA | Tarea | 
| PR | Presentación | 
| OTR | Otro |

## Arquitectura

La arquitectura de software utilizada para implementar la aplicación Study Mate, fue un modelo de capas formado por Vistas, Controlladores y Servicios. 
La aplicación se compone de diversos widgets que se pueden considerar como Vista o Controllador, puesto que además de ofrecer funcionalidades con las cuales el usuario puede interactuar, estas presentan la interfaz de los distintos componentes. Teniendo esto en cuenta seccionamos los distintos controladores según las funciones de agregar, actualizar y eliminar los recordatorios presentes en los eventos registrados. 

![enter image description here](https://i.imgur.com/47sMeZn.png)
