import 'package:flutter/material.dart';

class dialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  dialogueBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepOrange,
      content: Container(
        height: 150,
        child: Column(children: [
          const Text(
            'Add Note',
            style: TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.white,
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add your Note",
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // MyButton(text: 'save', onPressed: onSave),
              MaterialButton(
                onPressed: onSave,
                color: Colors.white,
                child: const Text(
                  'ADD Task',
                  style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),
                ),
              ),
              const SizedBox(width: 8),
              //MyButton(text: 'cancel', onPressed: onCancel)
            ],
          )
        ]),
      ),
    );
  }
}
