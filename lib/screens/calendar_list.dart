import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import 'event_list.dart';

class CalendarList extends StatelessWidget {
  final CalendarPlugin _myPlugin = CalendarPlugin();

  CalendarList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget futureBuilder = FutureBuilder<List<Calendar>?>(
      future: _fetchCalendars(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        List<Calendar> calendars = snapshot.data!;

        if (calendars.isEmpty) {
          return const Center(child: Text('No se encontraron calendarios. '));
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: calendars.length,
            itemBuilder: (context, index) {
              Calendar calendar = calendars[index];
              return ListTile(
                title: Text(calendar.name ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EventList(calendarId: calendar.id!);
                      },
                    ),
                  );
                },
              );
            });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Mate'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Calendars List',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            futureBuilder,
          ],
        ),
      ),
    );
  }

  Future<List<Calendar>?> _fetchCalendars() async {
    try {
      final hasPermissions = await _myPlugin.hasPermissions();
      if (!hasPermissions!) {
        await _myPlugin.requestPermissions();
      }

      return _myPlugin.getCalendars();
    } catch (e) {
      print('Error al obtener los calendarios: $e');
      return null;
    }
  }
}
