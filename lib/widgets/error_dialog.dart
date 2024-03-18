import 'package:flutter/material.dart';

class ErrorDialoge extends StatelessWidget {
  final String? message;
  const ErrorDialoge({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          // ignore: sort_child_properties_last
          child: const Center(
            child: Text("OK"),
          ),
          style: ElevatedButton.styleFrom(
            // ignore: deprecated_member_use
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
