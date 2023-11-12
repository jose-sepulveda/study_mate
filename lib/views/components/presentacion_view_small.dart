import 'package:flutter/material.dart';
import 'package:study_mate/models/presentacion.dart';

class PresentacionViewSmall extends StatelessWidget {
  const PresentacionViewSmall({
    super.key,
    required this.presentacion,
  });

  final Presentacion presentacion;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: ListTile(
        title: Text(presentacion.title),
        subtitle: Text(presentacion.location),
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
