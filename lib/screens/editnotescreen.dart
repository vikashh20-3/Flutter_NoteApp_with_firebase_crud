import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Note Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
