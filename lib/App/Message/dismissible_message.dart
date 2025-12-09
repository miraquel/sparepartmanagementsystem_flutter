import 'package:flutter/material.dart';

class DismissibleMessage extends StatelessWidget {
  const DismissibleMessage({
    super.key,
    required this.message,
    this.onDismissed,
  });

  final String message;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key(message),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          if (onDismissed != null) {
            onDismissed!();
          }
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ListTile(
          title: Text(message),
        ),
      ),
    );
  }
}
