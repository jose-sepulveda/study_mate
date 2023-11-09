import 'package:flutter/material.dart';
import 'package:study_mate/views/components/prueba_view_small.dart';
import 'package:study_mate/models/prueba.dart';

class PruebaEvent extends StatefulWidget {
  const PruebaEvent({super.key});

  @override
  State<PruebaEvent> createState() => _PruebaEvent();
}

class _PruebaEvent extends State<PruebaEvent> {
  List<Prueba> pruebas = [];

  @override
  void initState() {
    _initializePruebas();
    super.initState();
  }

  _initializePruebas() async {}
}
