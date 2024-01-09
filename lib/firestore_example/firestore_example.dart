import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_1/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreExample extends StatefulWidget {
  const FireStoreExample({super.key});
  static const String routeName = "/firestore";

  @override
  State<FireStoreExample> createState() => _FireStoreExampleState();
}

class _FireStoreExampleState extends State<FireStoreExample> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  File? file;
  String? tempUrl;

  void pickImage(ImageSource source) async {
    var selected =
        await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (selected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No image Selected")));
    } else {
      setState(() {
        file = File(selected.path);
      });
      saveToStorage();
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  saveToStorage() async {
    String filename = file!.path.split('/').last;
    var photo = await storage
        .ref()
        .child("users")
        .child(filename)
        .putFile(File(file!.path));

    String url = await photo.ref.getDownloadURL();
    setState(() {
      tempUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///List<String> data = ["a","b","c"]
            /// for (i =0 ;i<data.length;i++){
            /// print(data[i]);
            /// }
            ///
            /// for(var a in data){
            /// print(a)
            /// }
            ///
            StreamBuilder(
              stream: firestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                return ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot e) {
                    UserModel user =
                        UserModel.fromJson(e.data() as Map<String, dynamic>);
                    return ListTile(
                      title: Text(user.email),
                      // ?? means if null
                      subtitle: Text(user.firstname ?? "n/a"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  emailController.text = e['email'];
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Edit"),
                                      content: Container(
                                        height: 500,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: emailController,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  var data = {
                                                    "email":
                                                        emailController.text,
                                                  };
                                                  firestore
                                                      .collection('users')
                                                      .doc(e.id)
                                                      .update(data);
                                                },
                                                child: Text("Submit"))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                firestore
                                    .collection('users')
                                    .doc(e.id)
                                    .delete();
                              }),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const Text("first name"),
            TextFormField(controller: fnameController),
            const Text("last name"),
            TextFormField(controller: lnameController),
            const Text("email"),

            TextFormField(controller: emailController),

            file == null
                ? SizedBox()
                : Image.file(
                    file!,
                    height: 100,
                    width: 100,
                  ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Browse image"),
                        content: Container(
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                                child: Image.asset(
                                  "assets/images/camera.png",
                                  height: 100,
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/images/gallery.png",
                                  height: 100,
                                ),
                              )),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("Choose image")),
            ElevatedButton(
                onPressed: () async {
                  // FirebaseDatabase.instance.ref().child("").set(value);
                  var data = {
                    "firstname": fnameController.text,
                    "lastname": lnameController.text,
                    "email": emailController.text,
                  };
                  firestore.collection('users').doc().set(data);
                  // firestore.collection('users').doc("1").set(data);
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
