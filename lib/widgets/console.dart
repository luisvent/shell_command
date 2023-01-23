import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';

import 'console_text_field.dart';
import 'result_text_field.dart';

class Console extends StatefulWidget {
  const Console();

  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  final TextEditingController _consoleController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  late String commandToRun;
  late String commandResult;
  late FocusNode consoleFocusNode = FocusNode();

  resetConsole() {
    setState(() {
      commandToRun = '';
      _consoleController.clear();
    });
    focusConsole();
  }

  focusConsole() {
    consoleFocusNode.requestFocus();
  }

  runCommand() async {
    if (commandToRun == '\n' || commandToRun == '') {
      resetConsole();
    } else {
      if (commandToRun == 'cls' || commandToRun == 'clear') {
        resetConsole();
        _resultController.clear();
      } else {
        var shell = Shell(throwOnError: false);
        await shell.run(commandToRun).then((processResult) => {processCommandResult(processResult)}).onError((error, stackTrace) => {
              Future(() => {_resultController.text = '$commandToRun> command not recognized', resetConsole()})
            });
      }
    }
  }

  processCommandResult(List<ProcessResult> result) {
    commandResult = result.outText;
    _resultController.text = '> $commandToRun: \n\n${result.outText}';
    resetConsole();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                      width: 500,
                      height: 80,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (event) {
                          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                            commandToRun = _consoleController.value.text;
                            runCommand();
                          }
                        },
                        child: ConsoleTextField(consoleFocusNode: consoleFocusNode, consoleController: _consoleController),
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 28,
              ),
              Column(
                children: [
                  SizedBox(width: 500, height: 200, child: ResultTextField(resultController: _resultController)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
