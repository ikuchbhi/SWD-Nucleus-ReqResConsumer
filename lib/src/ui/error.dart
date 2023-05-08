import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final Object error;

  const Error(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          const Text("Error"),
          Text(error.toString()),
        ],
      ),
    );
  }
}
