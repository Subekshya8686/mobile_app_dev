// import 'package:batch_33a/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/model/user_model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  static const String routeName = "/form";

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration form"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: database.ref('contact').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.snapshot.value == null) {
                      return Text("No data found");
                    } else {
                      Map<dynamic, dynamic> datas =
                      snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> values = datas.values.toList();
                      List<dynamic> keys = datas.keys.toList();
                      return Column(
                        children: [
                          ...List.generate(values.length, (index) {
                            return ListTile(
                                title: Text(values[index]['email']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            fnameController.text =
                                            values[index]['firstname'];
                                            lnameController.text =
                                            values[index]['lastname'];
                                            emailController.text =
                                            values[index]['email'];
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Edit data"),
                                              content: Container(
                                                height: 600,
                                                child: Column(
                                                  children: [
                                                    Text("first name"),
                                                    TextFormField(
                                                        validator: (value) {
                                                          if (value == "") {
                                                            return "enter text";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                        fnameController),
                                                    Text("last name"),
                                                    TextFormField(
                                                        controller:
                                                        lnameController),
                                                    Text("email"),
                                                    TextFormField(
                                                        controller:
                                                        emailController),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          var data = {
                                                            "firstname":
                                                            fnameController
                                                                .text,
                                                            "lastname":
                                                            lnameController
                                                                .text,
                                                            "email":
                                                            emailController
                                                                .text,
                                                          };
                                                          await database
                                                              .ref('contact')
                                                              .child(
                                                              keys[index])
                                                              .update(data)
                                                              .then((value) {
                                                            // show success message to user
                                                          }).onError((error,
                                                              stackTrace) {
                                                            //show error to user
                                                          });
                                                        },
                                                        child: Text("update")),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () async {
                                          await database
                                              .ref('contact')
                                              .child(keys[index])
                                              .remove()
                                              .then((value) {
                                            // show success message to user
                                          }).onError((error, stackTrace) {
                                            //show error to user
                                          });
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                ));
                          })
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                },
              ),

              Text("first name"),
              TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "enter text";
                    }
                    return null;
                  },
                  controller: fnameController),
              Text("last name"),
              TextFormField(controller: lnameController),
              Text("email"),
              TextFormField(controller: emailController),

              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      UserModel model = UserModel(
                          email: emailController.text,
                          firstname: fnameController.text,
                          lastname: lnameController.text);
                      await database
                          .ref()
                          .child("contact")
                          .push()
                          .set(model.toJson())
                          .then((value) {
                        fnameController.clear();
                        lnameController.clear();
                        emailController.clear();
                      }).onError((error, stackTrace) {
                        print(error.toString());
                      });
                    }
                  },
                  child: Text("Submit")),

              ///
              ///Futurebuilder
              ///
              ///Streambuilder
              ///
            ],
          ),
        ),
      ),
    );
  }
}