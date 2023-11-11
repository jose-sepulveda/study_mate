import 'package:flutter/material.dart';
import 'package:study_mate/models/tarea.dart';

class TareaViewSmall extends StatelessWidget {
  const TareaViewSmall({
    super.key,
    required this.tarea,
  });

  final Tarea tarea;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        title: Text(tarea.title),
        subtitle: Text(tarea.location),
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
