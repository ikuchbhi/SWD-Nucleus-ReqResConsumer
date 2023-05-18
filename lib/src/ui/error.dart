import 'package:flutter/material.dart';
import '../common/constants.dart';

class Error extends StatelessWidget {
  final Object error;

  const Error(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 40.0,
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Text(
          ERROR_BUTTON,
          style: TextStyle(fontSize: 24.0),
        ),
        Text(
          error.toString(),
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
