import 'package:flutter/material.dart';
import 'package:study_mate/models/otro.dart';

class OtroViewSmall extends StatelessWidget {
  const OtroViewSmall({
    super.key,
    required this.otro,
  });

  final Otro otro;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: ListTile(
        title: Text(otro.title),
        subtitle: Text(otro.location),
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
