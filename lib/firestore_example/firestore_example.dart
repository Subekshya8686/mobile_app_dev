import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/constants/app_image.dart';
import 'package:flutter_1/model/user_model.dart';
import 'package:flutter_1/providers/user_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  late UserViewModel _userViewModel;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userViewModel = Provider.of<UserViewModel>(context, listen: false);
      _userViewModel.fetchData();
    });

    super.initState();
  }

  @override
  File? file;
  String? tempUrl;

  void pickImage(ImageSource source) async {
    var selected =
    await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (selected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No image selected")));
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
    print("This is url");
    print(url);
    setState(() {
      tempUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserViewModel>(builder: (context, user, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: user.data
                    .map((e) => ListTile(
                  title: Text(e.data().firstname ?? ""),
                  subtitle: Text(e.data().email ?? ""),
                ))
                    .toList(),
              ),

              ///List<String> data = ["a","b","c"]
              /// for (i =0 ;i<data.length;i++){
              /// print(data[i]);
              /// }
              ///
              /// for(var a in data){
              /// print(a)
              /// }
              ///
              // StreamBuilder(
              //   stream: firestore.collection('users').snapshots(),
              //   builder: (context, snapshot) {
              //     return ListView(
              //       physics: const ScrollPhysics(),
              //       shrinkWrap: true,
              //       children: snapshot.data!.docs.map((DocumentSnapshot e) {
              //         UserModel user =
              //             UserModel.fromJson(e.data() as Map<String, dynamic>);
              //         return ListTile(
              //           leading: Image.network(user.image.toString()),
              //           title: Text(user.email),
              //           // ?? means if null
              //           subtitle: Text(user.firstname ?? "n/a"),
              //           trailing: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               IconButton(
              //                   icon: Icon(Icons.edit),
              //                   onPressed: () {
              //                     setState(() {
              //                       emailController.text = e['email'];
              //                     });
              //                     showDialog(
              //                       context: context,
              //                       builder: (context) {
              //                         return AlertDialog(
              //                           title: Text("Edit"),
              //                           content: Container(
              //                             height: 500,
              //                             child: Column(
              //                               children: [
              //                                 TextFormField(
              //                                   controller: emailController,
              //                                 ),
              //                                 ElevatedButton(
              //                                     onPressed: () {
              //                                       var data = {
              //                                         "email":
              //                                             emailController.text,
              //                                       };
              //                                       firestore
              //                                           .collection('users')
              //                                           .doc(e.id)
              //                                           .update(data);
              //                                     },
              //                                     child: Text("Submit"))
              //                               ],
              //                             ),
              //                           ),
              //                         );
              //                       },
              //                     );
              //                   }),
              //               IconButton(
              //                   icon: Icon(Icons.delete),
              //                   onPressed: () {
              //                     firestore
              //                         .collection('users')
              //                         .doc(e.id)
              //                         .delete();
              //                   }),
              //             ],
              //           ),
              //         );
              //       }).toList(),
              //     );
              //   },
              // ),
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
                          title: const Text("Browse image"),
                          content: SizedBox(
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      child: Image.asset(
                                        pngCamera,
                                        height: 100,
                                      ),
                                    )),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                      },
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
                    UserModel data = UserModel(
                        email: emailController.text,
                        image: tempUrl,
                        firstname: fnameController.text,
                        lastname: lnameController.text);
                    user.saveData(data);
                  },
                  child: Text("Submit"))
            ],
          ),
        );
      }),
    );
  }
}