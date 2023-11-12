import 'package:flutter/material.dart';

class UpdateEventScreen extends StatefulWidget {
  // Puedes pasar los datos del evento actual como parámetros si es necesario
  final String title;
  final String description;
  final String location;

  UpdateEventScreen({
    required this.title,
    required this.description,
    required this.location,
  });

  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  // Puedes utilizar un controlador para manejar los valores del formulario
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
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    locationController.text = widget.location;
    // Inicializa los controladores con los valores actuales del evento
    // ...
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
            TextField(
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

                Navigator.pop(context,
                    UpdatedEvent); // Cierra la pantalla de actualización
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
}
