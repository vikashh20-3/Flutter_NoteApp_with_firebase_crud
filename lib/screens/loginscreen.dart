import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/screens/forgotpassword.dart';
import 'package:noteapp/screens/signupscreen.dart';

import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isVisible = true;
  TextEditingController LoginEmailController = TextEditingController();
  TextEditingController LoginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("LoginScreen"),
            // actions: const [Icon(Icons.more_vert_rounded)],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(child: Lottie.asset("assets/87845-hello.json")),
              Container(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextFormField(
                  controller: LoginEmailController,
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
              Container(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextFormField(
                  controller: LoginPasswordController,
                  obscureText: isVisible,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      hintText: "Enter your Password",
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: "Password"),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  // ignore: empty_catches
                  onPressed: () async {
                    var LoginEmail = LoginEmailController.text.trim();
                    var LoginPassword = LoginPasswordController.text.trim();

                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: LoginEmail, password: LoginPassword))
                          .user;
                      if (firebaseUser != null) {
                        Get.off(() => const HomeScreen());
                      }
                      {
                        log("Check email and passowrd");
                      }
                    } on FirebaseAuthException catch (e) {
                      log("Error $e");
                    }
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(() => const ForgotPassword());
                      },
                      child: const Card(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Forgot Password?"),
                      ))),
                  InkWell(
                      onTap: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: const Card(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Don't have an account Sign up "),
                      )))
                ],
              ),
            ]),
          ),
        ));
  }
}
