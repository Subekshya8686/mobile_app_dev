import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_1/model/user_model.dart';

class UserRepo {
  final instance = FirebaseFirestore.instance.collection("users").withConverter(
    fromFirestore: (snapshot, options) =>
        UserModel.fromJson(snapshot.data() as Map<String, dynamic>),
    toFirestore: (UserModel value, options) => value.toJson(),
  );

  ///post

  Future<dynamic> saveData(UserModel data) async {
    try {
      final response = await instance.add(data);
      return response;
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return null;
  }

  ///get

  Future<List<QueryDocumentSnapshot<UserModel>>> getData() async {
    try {
      final response = (await instance.get()).docs;
      return response;
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return [];
  }

//post
//update
//delete
}