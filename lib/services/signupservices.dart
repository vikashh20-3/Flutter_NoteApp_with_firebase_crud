import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../screens/loginscreen.dart';

signUpUser(String userName, String userEmail, String userPassword,
    String userPhone) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      "userName": userName,
      "userPhone": userPhone,
      "useremail": userEmail,
      "userPassword": userPassword,
      "Created at ": DateTime.now(),
      "User Id": userid.uid,
    }).then((value) => Get.to(() => const LoginScreen()));
  } on FirebaseAuthException catch (e) {
    log("This is the error we are getting while saving the data to firebase databse $e");
  }
}
