// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'package:study_mate/views/presentacion/create.dart';
import 'package:study_mate/views/home.dart';
import 'package:study_mate/views/presentacion/update.dart';

import '../event_details.dart';

class PresentacionList extends StatefulWidget {
  const PresentacionList({super.key});

  @override
  _PresentacionListState createState() => _PresentacionListState();
}

class _PresentacionListState extends State<PresentacionList> {
  final CalendarPlugin _myPlugin = CalendarPlugin();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Presentaciones'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
      ),
      body: FutureBuilder<List<CalendarEvent>?>(
        future: _fetchEventsFromMaxIdCalendar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No hay eventos encontrados'));
          }
          List<CalendarEvent> events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              CalendarEvent event = events.elementAt(index);
              return Dismissible(
                key: Key(event.eventId!),
                confirmDismiss: (direction) async {
                  if (DismissDirection.startToEnd == direction) {
                    setState(() {
                      _deleteEvent(event.eventId!);
                    });

                    return true;
                  } else {
                    setState(() {
                      _updateEvent(event);
                    });

                    return false;
                  }
                },
                // delete option
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                // update the event
                secondaryBackground: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 225, 67, 4),
                    ),
                    child: ListTile(
                      title: Text(event.title!),
                      subtitle: Text(event.startDate!.toIso8601String()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EventDetails(
                                activeEvent: event,
                                calendarPlugin: _myPlugin,
                              );
                            },
                          ),
                        );
                      },
                      onLongPress: () {
                        //_deleteReminder(event.eventId!);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (!mounted) return;

          MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) {
              return const CreateEventScreen();
            },
          );
          await Navigator.of(context).push(route);
        },
      ),
    );
  }

  // Funcion listar eventos

  Future<List<CalendarEvent>?> _fetchEventsFromMaxIdCalendar() async {
    try {
      final hasPermissions = await _myPlugin.hasPermissions();
      if (!hasPermissions!) {
        await _myPlugin.requestPermissions();
      }
      final calendars = await _myPlugin.getCalendars();
      if (calendars == null || calendars.isEmpty) {
        print('No se encontraron calendarios');
        return null;
      }
      final maxIdCalendar = await _getCalendar();
      if (maxIdCalendar == null) {
        print('No se encontró un calendario con la ID máxima');
        return null;
      }
      final allEvents = await _myPlugin.getEvents(calendarId: maxIdCalendar);
      final filteredEvents = allEvents
          ?.where((event) => event.title?.contains('PR') ?? false)
          .toList();

      return filteredEvents;
    } catch (e) {
      print('Error al obtener los eventos del calendario con la ID máxima: $e');
      return null;
    }
  }

  // Entrega CalendarId

  Future<String> _getCalendar() async {
    Calendar? maxIdCalendar;
    String maxId = '';

    final calendars = await _myPlugin.getCalendars();
    maxIdCalendar = calendars?.firstWhere(
      (calendar) => calendar.name!.contains('@gmail.com'),
    );

    if (maxIdCalendar != null) {
      maxId = maxIdCalendar.id!;
    }
    return maxId;
  }

  // ignore: unused_element
  Future<List<CalendarEvent>?> _fetchEventsByDateRange() async {
    final maxIdCalendar = await _getCalendar();
    final DateTime endDate =
        DateTime.now().toUtc().add(const Duration(hours: 23, minutes: 59));
    DateTime startDate = endDate.subtract(const Duration(days: 3));
    return _myPlugin.getEventsByDateRange(
      calendarId: maxIdCalendar,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void _deleteEvent(String eventId) async {
    final maxIdCalendar = await _getCalendar();
    _myPlugin
        .deleteEvent(calendarId: maxIdCalendar, eventId: eventId)
        .then((isDeleted) {
      debugPrint('Is Event deleted: $isDeleted');
    });
  }

  void _updateEvent(CalendarEvent event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return UpdateEventScreen(
            // Pasa los datos actuales del evento
            eventId: event.eventId!,
            title: event.title!,
            description: event.description ?? '',
            location: event.location ?? '',
            startdate: event.startDate!,
          );
        },
      ),
    );
  }
}
