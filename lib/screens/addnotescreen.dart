import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/screens/homescreen.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController userNoteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Note")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: userNoteController,
            maxLines: null,
            decoration:
                const InputDecoration(enabledBorder: OutlineInputBorder()),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            var userNote = userNoteController.text.trim();
            if (userNote != "") {
              try {
                await FirebaseFirestore.instance.collection("notes").doc().set({
                  "Created At": DateTime.now(),
                  "note": userNote,
                  "userId": userId!.uid,
                }).then((value) => {
                  Get.off(()=>const HomeScreen()),
                });
              } catch (e) {
                log("Error while saving the notes $e");
              }
            }
          },
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
