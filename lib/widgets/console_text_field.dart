import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsoleTextField extends StatelessWidget {
  const ConsoleTextField({
    Key? key,
    required this.consoleFocusNode,
    required TextEditingController consoleController,
  })  : _consoleController = consoleController,
        super(key: key);

  final FocusNode consoleFocusNode;
  final TextEditingController _consoleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: consoleFocusNode,
      autofocus: true,
      controller: _consoleController,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(
        fontFamily: 'Source Code Pro',
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
