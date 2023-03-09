import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/screens/loginscreen.dart';

import '../services/signupservices.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isVisible = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("SignUp"),
            // actions: const [Icon(Icons.more_vert_rounded)],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Lottie.asset("assets/118046-lf20-oahmox5rjson.json")),
              Container(
                // width: MediaQuery.of(context).size.width-50,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextFormField(
                  controller: userPhoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Enter your phone",
                      prefixIcon: Icon(Icons.person),
                      labelText: "Phone"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                // width: MediaQuery.of(context).size.width-50,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextFormField(
                  controller: userEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: "Email"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                // width: MediaQuery.of(context).size.width-50,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Create a username",
                      prefixIcon: Icon(Icons.person_3_rounded),
                      labelText: "Username"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                //  width: MediaQuery.of(context).size.width-50,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextFormField(
                  controller: userPasswordController,
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
                  onPressed: () async {
                    var userName = userNameController.text.trim();
                    var userPhone = userPhoneController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: userEmail, password: userPassword)
                        .then((value) => {
                              log("user created"),
                              signUpUser(
                                userName,
                                userEmail,
                                userPassword,
                                userPhone
                              ) 
                            });
                  },
                  child: Text("Sign In ")),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                child: const Card(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Already have an account ?"),
                )),
              )
            ]),
          ),
        ));
  }
}
