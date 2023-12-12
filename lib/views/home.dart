// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'package:study_mate/services/ponderador.dart';
import 'package:study_mate/views/notas/notas.dart';
import 'package:study_mate/views/recordatorios.dart';
import 'package:study_mate/provider/calendar_state.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
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
      home: const MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final CalendarPlugin _myPlugin = CalendarPlugin();

  int screen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StudyMate',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 80.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recordatorios()));
                      print('Botón Recordatorios presionado');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 181, 58, 9),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.pending_actions,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Recordatorios',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 80.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Notas()));
                        print('Botón Tareas presionado');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 106, 5, 238),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.note_add,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Notas',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 80.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ponderador()));
                      print('Botón Ponderador presionado');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 100, 225),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.calculate, size: 30, color: Colors.white),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Ponderador',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: _chooseCalendar,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.calendar_today, size: 30, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Elegir Calendario',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                  width: double.infinity,
                  height: 80.0,
                  child: ElevatedButton(
                      onPressed: () {
                        showPopup(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.info, size: 30, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            'Acerca de',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ],
                      )))
            ],
          ),
        ),
      ][screen],
      bottomNavigationBar: NavigationBar(
        selectedIndex: screen,
        onDestinationSelected: (int index) {
          screen = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'inicio',
            selectedIcon: Icon(Icons.home_filled),
            tooltip: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
            selectedIcon: Icon(Icons.settings),
            tooltip: 'Ajustes',
          ),
        ],
      ),
    );
  }

  static void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acerca de...'),
          content: const Text(
              'Nombre: StudyMate \nDescripción: Esta es una aplicación en desarrollo para la creación de eventos académicos que serán registrados en su calendario \nVersión: 1.0.0'),
          actions: [
            TextButton(
              onPressed: () {
                // Cerrar la ventana emergente
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<List<Calendar>> _getAllGmailCalendars() async {
    List<Calendar> gmailCalendars = [];

    final calendars = await _myPlugin.getCalendars();

    final filteredCalendars = calendars?.where(
      (calendar) => calendar.name!.contains('@gmail.com'),
    );

    if (filteredCalendars != null) {
      gmailCalendars = filteredCalendars.toList();
    }

    return gmailCalendars;
  }

  Future<void> _chooseCalendar() async {
    List<Calendar> calendars = await _getAllGmailCalendars();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Elegir Calendario'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.all(1.0), // Aquí ajustas el padding
                width:
                    MediaQuery.of(context).size.width, // Aquí ajustas el ancho
                child: ListView.builder(
                  itemCount: calendars.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(calendars[index].name!),
                      leading: Radio<String>(
                        value: calendars[index].id!,
                        groupValue: Provider.of<CalendarState>(context)
                            .chosenCalendarId,
                        onChanged: (String? value) {
                          setState(() {
                            Provider.of<CalendarState>(context, listen: false)
                                .chosenCalendarId = value;
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop(
                    Provider.of<CalendarState>(context, listen: false)
                        .chosenCalendarId);
              },
            )
          ],
        );
      },
    );
  }
}
