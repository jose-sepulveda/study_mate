import 'package:flutter/material.dart';
import 'package:study_mate/components/note_view_small.dart';
import 'package:study_mate/models/note.dart';
import 'package:study_mate/services/notes.dart';
import 'package:study_mate/views/home.dart';
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
    return MaterialApp(
      title: 'App Theme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          onSurface: Colors.blue,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.red,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.dark,
          ),
          useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notas',
            style: TextStyle(fontSize: 30),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
        ),
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
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
