import 'package:flutter/material.dart';
import 'package:study_mate/views/pruebas/prueba_list.dart';

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
                              builder: (context) => const PruebaList()));
                      print('Botón Pruebas presionado');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.pending_actions,
                          size: 30,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Pruebas',
                          style: TextStyle(fontSize: 25),
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
                                builder: (context) => const TareaList()));
                        print('Botón Tareas presionado');
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.note_alt_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Tareas',
                            style: TextStyle(fontSize: 25),
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
                              builder: (context) => const PresentacionList()));
                      print('Botón Presentaciones presionado');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.personal_video,
                          size: 30,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Presentaciones',
                          style: TextStyle(fontSize: 25),
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
                                builder: (context) => const OtroList()));
                        print('Botón Otros presionado');
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.school,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'Otros',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      )),
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
                      onPressed: () {
                        showPopup(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            size: 30,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Acerca de',
                            style: TextStyle(fontSize: 30),
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
}
