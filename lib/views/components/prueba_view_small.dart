import 'package:flutter/material.dart';
import 'package:study_mate/models/prueba.dart';

class PruebaViewSmall extends StatelessWidget {
  const PruebaViewSmall({
    super.key,
    required this.prueba,
  });

  final Prueba prueba;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        title: Text(prueba.title),
        subtitle: Text(prueba.location),
        textColor: Colors.black,
        trailing: PopupMenuButton(
            color: Colors.black,
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Editar'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Eliminar'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                //Editar
                //onEdit?.call();
              } else if (value == 1) {
                //Eliminar
                //onDelete?.call();
              }
            }),
      ),
    );
  }
}
