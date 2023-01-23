import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultTextField extends StatelessWidget {
  const ResultTextField({
    Key? key,
    required TextEditingController resultController,
  })  : _resultController = resultController,
        super(key: key);

  final TextEditingController _resultController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: _resultController,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(
        fontFamily: 'Source Code Pro',
        fontSize: 12,
        color: Colors.greenAccent,
      ),
      maxLines: 90,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(50, 0, 0, 0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(8),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
