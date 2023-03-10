import 'dart:developer' as log ;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/screens/homescreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();
  var note = Get.arguments['notes'].toString();
  var id = Get.arguments['userid'].toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Your Note"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: noteController..text = "$note",
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var updatednote = noteController.text.trim();
                await FirebaseFirestore.instance
                    .collection("notes")
                    .doc(id)
                    .update({"note": updatednote}).then((value) => {
                        log.log("Data fetched "),
                        Get.off(()=>const HomeScreen()),
                    });
              },
              child: const Text("Update the note"))
        ],
      ),
    );
  }
}
