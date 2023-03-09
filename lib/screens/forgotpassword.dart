import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/screens/loginscreen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Forgot Password"),
        // actions: const [Icon(Icons.more_vert_rounded)],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Lottie.asset("assets/112418-forgot-password.json")),
          Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: TextFormField(
              controller: forgotEmailController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.person_3_rounded),
                  labelText: "Email"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () async {
                var forgotEmail = forgotEmailController.text.trim();

                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: forgotEmail)
                      .then((value) => Get.off(() => const LoginScreen()));
                } on FirebaseAuthException catch (e) {
                  log("Error while sending Forgot email $e ");
                }
              },
              child: const Text("Forgot Password ")),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
