import 'package:flutter/material.dart';
import 'package:study_mate/views/home.dart';

class Ponderador extends StatefulWidget {
  const Ponderador({Key? key}) : super(key: key);

  @override
  _PonderadorState createState() => _PonderadorState();
}

class _PonderadorState extends State<Ponderador> {
  List<Row> _rows = [];
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _addRow();
    _addRow();
  }

  void _addRow() {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    _controllers.add(controller1);
    _controllers.add(controller2);

    setState(() {
      _rows.add(Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller1,
                decoration: const InputDecoration(
                  hintText: 'Nota (Ej: 7.0)',
                ),
                style: const TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                  hintText: 'Porcentaje',
                ),
                style: const TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ));
    });
  }

  void _removeRow() {
    if (_rows.isNotEmpty) {
      _controllers.removeLast();
      _controllers.removeLast();

      setState(() {
        _rows.removeLast();
      });
    }
  }

  void _calculate() {
    double total = 0;

    for (int i = 0; i < _controllers.length; i += 2) {
      double nota = double.parse(_controllers[i].text);
      int porcentaje = int.parse(_controllers[i + 1].text);
      total += nota * porcentaje / 100;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ponderación'),
          content: Text('La ponderación total es: ${total.toStringAsFixed(1)}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              'Ponderador',
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
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 4, 100, 225),
                onPressed: _addRow,
                tooltip: 'Agregar fila',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 4, 100, 225),
                onPressed: _removeRow,
                tooltip: 'Eliminar última fila',
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 4, 100, 225),
                onPressed: _calculate,
                tooltip: 'Calcular ponderación',
                child: const Icon(Icons.calculate),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: _rows.length,
            itemBuilder: (BuildContext context, int index) {
              return _rows[index];
            },
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
