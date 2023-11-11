// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import 'event_details.dart';

class PruebaList extends StatefulWidget {
  const PruebaList({super.key});

  @override
  _PruebaListState createState() => _PruebaListState();
}

class _PruebaListState extends State<PruebaList> {
  final CalendarPlugin _myPlugin = CalendarPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events List'),
      ),
      body: FutureBuilder<List<CalendarEvent>?>(
        future: _fetchEventsFromMaxIdCalendar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No Events found'));
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addEvent();
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
      final maxIdCalendar = await _getCalendarWithMaxId();
      if (maxIdCalendar == null) {
        print('No se encontró un calendario con la ID máxima');
        return null;
      }
      final allEvents = await _myPlugin.getEvents(calendarId: maxIdCalendar);
      final filteredEvents = allEvents
          ?.where((event) => event.title?.contains('PB') ?? false)
          .toList();

      return filteredEvents;
    } catch (e) {
      print('Error al obtener los eventos del calendario con la ID máxima: $e');
      return null;
    }
  }

  // Entrega CalendarId

  Future<String> _getCalendarWithMaxId() async {
    Calendar? maxIdCalendar;
    String maxId = '';

    final calendars = await _myPlugin.getCalendars();
    if (calendars == null || calendars.isEmpty) {
      print('No se encontraron calendarios');
      return maxId;
    }

    for (var calendar in calendars) {
      if (maxIdCalendar == null ||
          int.parse(calendar.id!) > int.parse(maxIdCalendar.id!)) {
        maxIdCalendar = calendar;
      }
    }
    if (maxIdCalendar != null) {
      maxId = maxIdCalendar.id!;
    }
    return maxId;
  }

  // ignore: unused_element
  Future<List<CalendarEvent>?> _fetchEventsByDateRange() async {
    final maxIdCalendar = await _getCalendarWithMaxId();
    final DateTime endDate =
        DateTime.now().toUtc().add(const Duration(hours: 23, minutes: 59));
    DateTime startDate = endDate.subtract(const Duration(days: 3));
    return _myPlugin.getEventsByDateRange(
      calendarId: maxIdCalendar,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void _addEvent() async {
    final maxIdCalendar = await _getCalendarWithMaxId();

    DateTime startDate = DateTime.now();
    DateTime endDate = startDate.add(const Duration(hours: 3));
    CalendarEvent newEvent = CalendarEvent(
      title: 'PB' + ' Taller de desarrollo',
      description: 'test plugin description',
      startDate: startDate,
      endDate: endDate,
      location: 'Chennai, Tamilnadu',
    );
    _myPlugin
        .createEvent(calendarId: maxIdCalendar, event: newEvent)
        .then((evenId) {
      setState(() {
        debugPrint('Event Id is: $evenId');
      });
    });
  }

  void _deleteEvent(String eventId) async {
    final maxIdCalendar = await _getCalendarWithMaxId();
    _myPlugin
        .deleteEvent(calendarId: maxIdCalendar, eventId: eventId)
        .then((isDeleted) {
      debugPrint('Is Event deleted: $isDeleted');
    });
  }

  void _updateEvent(CalendarEvent event) async {
    final maxIdCalendar = await _getCalendarWithMaxId();
    event.title = 'Updated from Event';
    event.description = 'Test description is updated now';
    event.attendees = Attendees(
      attendees: [
        Attendee(emailAddress: 'updatetest@gmail.com', name: 'Update Test'),
      ],
    );
    _myPlugin
        .updateEvent(calendarId: maxIdCalendar, event: event)
        .then((eventId) {
      debugPrint('${event.eventId} is updated to $eventId');
    });

    if (event.hasAlarm!) {
      _updateReminder(event.eventId!, 65);
    } else {
      _addReminder(event.eventId!, -30);
    }
  }

  void _addReminder(String eventId, int minutes) async {
    final maxIdCalendar = await _getCalendarWithMaxId();
    _myPlugin.addReminder(
        calendarId: maxIdCalendar, eventId: eventId, minutes: minutes);
  }

  void _updateReminder(String eventId, int minutes) async {
    final maxIdCalendar = await _getCalendarWithMaxId();
    _myPlugin.updateReminder(
        calendarId: maxIdCalendar, eventId: eventId, minutes: minutes);
  }

  void _deleteReminder(String eventId) async {
    _myPlugin.deleteReminder(eventId: eventId);
  }
}
