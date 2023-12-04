import 'package:flutter/material.dart';
import 'package:study_mate/services/notes.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nueva Nota'),
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
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Contenido',
                  ),
                  minLines: 5,
                  maxLines: 10,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    String title = titleController.text;
                    String content = contentController.text;

                    await NotesService.create(title: title, content: content);

                    if (!mounted) return;

                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurpleAccent),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.inversePrimary)),
                  child: const Text('Crear Nota'),
                ),
              ],
            ),
          ),
        ));
  }
}
