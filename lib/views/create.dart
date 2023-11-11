import 'package:flutter/material.dart';
import 'package:study_mate/views/event_details.dart';

import 'package:study_mate/views/prueba_list.dart';

class CreatePruebaScreen extends StatefulWidget {
  const CreatePruebaScreen({Key? key}) : super(key: key);

  @override
  State<CreatePruebaScreen> createState() => _CreatePruebaScreenState();
}

class _CreatePruebaScreenState extends State<CreatePruebaScreen> {
  //start_date
  //end_date
  //all_day;
  //alarm;
  //reminder;

  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Prueba'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Card(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Titulo'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    String title = titleController.text;
                    String location = locationController.text;

                    await PruebaList._addEvent();
                  },
                  child: child)
            ],
          ),
        ),
      ),
    );
  }
}
