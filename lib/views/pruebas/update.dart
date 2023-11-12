import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'package:study_mate/views/pruebas/prueba_list.dart';

class UpdateEventScreen extends StatefulWidget {
  // Puedes pasar los datos del evento actual como parámetros si es necesario

  final String eventId;
  final String title;
  final String description;
  final String location;
  final DateTime startdate;

  UpdateEventScreen({
    required this.eventId,
    required this.title,
    required this.description,
    required this.location,
    required this.startdate,
  });

  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  // Puedes utilizar un controlador para manejar los valores del formulario
  final CalendarPlugin _myPlugin = CalendarPlugin();
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime startDate = DateTime.now();
  Duration duration = Duration(hours: 1);
  List<Duration> durations = [
    Duration(hours: 1),
    Duration(hours: 2),
    Duration(hours: 3),
  ];

  @override
  void initState() {
    super.initState();
    idController.text = widget.eventId;
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    locationController.text = widget.location;
    startDate = widget.startdate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              enabled: false,
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Id',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Ubicación',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != startDate) {
                  setState(() {
                    startDate = picked;
                  });
                }
              },
              child: Text('Fecha de inicio: ${startDate.toLocal()}'),
            ),
            const SizedBox(height: 10),
            DropdownButton<Duration>(
                value: duration,
                items:
                    durations.map<DropdownMenuItem<Duration>>((Duration value) {
                  return DropdownMenuItem<Duration>(
                    value: value,
                    child: Text('${value.inHours} horas'),
                  );
                }).toList(),
                onChanged: (Duration? newValue) {
                  setState(() {
                    duration = newValue!;
                  });
                }),
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para actualizar el evento con los nuevos valores
                _updateEvent();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PruebaList()));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrangeAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.black)),
              child: const Text('Actualizar Prueba'),
            ),
          ],
        ),
      ),
    );
  }

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

  void _updateEvent() async {
    final maxIdCalendar = await _getCalendar();
    final CalendarEvent event_upgrade = CalendarEvent(
      eventId: idController.text,
      title: titleController.text,
      description: descriptionController.text,
      location: locationController.text,
      startDate: startDate,
      endDate: startDate.add(const Duration(hours: 1)),
    );
    _myPlugin
        .updateEvent(calendarId: maxIdCalendar, event: event_upgrade)
        .then((idController) {
      debugPrint('${event_upgrade.eventId} is updated to $idController');
    });
  }
}
