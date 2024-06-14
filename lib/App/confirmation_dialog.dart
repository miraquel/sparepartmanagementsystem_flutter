// create a stateless confirmation dialog

import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final Future<void> Function()? onConfirm;
  final Future<void> Function()? onCancel;
  final Widget? title;
  final Widget? content;
  final Widget? onCancelButton;
  final Widget? onConfirmButton;
  const ConfirmationDialog({super.key, this.onConfirm, this.onCancel, this.title, this.content, this.onCancelButton, this.onConfirmButton});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title ?? const Text('Confirmation'),
      content: content ?? const Text('Are you sure you want to continue?'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          // text button style with background color red, white text color, and small border radius
          style: TextButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          child: onCancelButton ?? const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: onConfirm ?? () => Navigator.of(context).pop(),
          // text button style with background color green, white text color, and small border radius
          style: TextButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          child: onConfirmButton ?? const Text('Confirm', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
