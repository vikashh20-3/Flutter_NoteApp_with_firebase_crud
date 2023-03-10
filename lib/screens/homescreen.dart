import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/screens/addnotescreen.dart';
import 'package:noteapp/screens/editnotescreen.dart';

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
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("notes").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                    child: Lottie.asset('assets/loading.json'),
                  ));
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Center(child: Text("No data found")),
                  );
                } else {
                  log("Data fetched to home screen ");
                  return Column(children: [
                    // ListView.builder(
                    //   itemCount: snapshot.data!.docs.length,
                    //   itemBuilder: ((context, index) {
                    //     return  Card(
                    //       child: ListTile(
                    //         title: Text("h"),
                    //                           ),
                    //     );
                    //   }),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var notes = snapshot.data!.docs[index]['note'];
                        var userId = snapshot.data!.docs[index]['userId'];
                        var userid = snapshot.data!.docs[index].id;
                        return Card(
                          child: ListTile(
                            //         title: Text("h"),
                            title: Text(notes),
                            subtitle: Text(userid),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    log(userid);
                                    Get.to(() => const EditNoteScreen(),
                                        arguments: {
                                          'notes': notes,
                                          'userid': userid,
                                        });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('notes')
                                        .doc(userid)
                                        .delete();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Icon(Icons.delete),
                                  ),
                                )
                              ],
                            ),
                            // title: Text("h"),
                            //                           ),
                          ),
                        );
                      },
                    )
                  ]);
                }

                // Text(snapshot.data!.docs[0].get('note')),
                // snapshot.data!.docs[0].get('userId'),
                // snapshot.data!.docs[0].get('email'),
                // snapshot.data!.docs[0].get('url'),
                // )]
                // );
              }
              // }
              ),
        ),
        // SizedBox(
        //     height: 120,
        //     width: MediaQuery.of(context).size.width,
        //     child: Image.asset("assets/images/N.jpg")),

        //                 _contactCard(
        //                     "Our Office Address",
        //                     address,
        //                     snapshot.data.docs[0].get('number'),
        //                     snapshot.data.docs[0].get('name'),
        // snapshot.data.docs[0].get('email'),
        //                     snapshot.data.docs[0].get('url'),
        //                 ),

        // }
        // body: StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection("users")
        //         .where("userId", isEqualTo: userId?.uid)
        //         .snapshots(),
        //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text("Something went wrong ");
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CupertinoActivityIndicator());
        //       }
        //       if (snapshot.data!.docs.isEmpty) {
        //         return const Text("No data found ");
        //       }
        //       if (snapshot.hasData) {
        //         // final docs = snapshot.data!.docs;
        //         return ListView.builder(
        //           itemCount: snapshot.data!.docs.length,
        //           itemBuilder: (context, index) {
        //             final data = snapshot.data!.docs[index]['note'];
        //             return ListTile(
        //               title: Text(data['note']),
        //               // subtitle: Text(data['phone']),
        //             );
        //           },
        //         );
        // }
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
        //   return Container();
        // }),
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
