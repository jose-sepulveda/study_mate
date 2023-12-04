import 'package:flutter/material.dart';
import 'package:study_mate/components/note_view_small.dart';
import 'package:study_mate/models/note.dart';
import 'package:study_mate/services/notes.dart';
import 'package:study_mate/views/notas/create.dart';
import 'package:study_mate/views/notas/update.dart';

class Notas extends StatefulWidget {
  const Notas({super.key});

  @override
  State<Notas> createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  List<Note> notes = [];

  @override
  void initState() {
    _initializeNotes();
    super.initState();
  }

  _initializeNotes() async {
    notes = await NotesService.listAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Notes'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () async {
          if (!mounted) return;

          MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) {
              return const CreateNoteScreen();
            },
          );
          await Navigator.of(context).push(route);
          await _initializeNotes();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            Note note = notes[index];

            return NoteViewSmall(
              note: note,
              onEdit: () async {
                //Editar
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) {
                    return UpdateNoteScreen(note: note);
                  },
                );
                await Navigator.of(context).push(route);
                await _initializeNotes();
              },
              onDelete: () async {
                //Eliminar
                await NotesService.deleteOne(note: note);
                await _initializeNotes();
              },
            );
          }),
    );
  }
}
