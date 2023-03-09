import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/screens/addnotescreen.dart';

import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("Home Screen"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.off(() => const LoginScreen());
                  },
                  child: const Icon(Icons.login_outlined),
                ),
              )
            ]),
        body: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("userId", isEqualTo: userId?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong ");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text("No data found ");
                  }
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index]['note'];
                        return ListTile(
                          title: Text(data['note']),
                          // subtitle: Text(data['phone']),
                        );
                      },
                    );
                  }
                  // if (snapshot.data != null && snapshot != null) {
                  //   return ListView.builder(
                  //     itemCount: snapshot.data!.docs.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         child: ListTile(
                  //             title: Text(snapshot.data!.docs[index]['note'])),
                  //       );
                  //     },
                  //   );
                  // }
                  return Container();
                })),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 10),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const AddNoteScreen());
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
