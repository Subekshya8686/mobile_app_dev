import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/model/user_model.dart';
import 'package:flutter_1/repository/user_repo.dart';

class UserViewModel with ChangeNotifier {
  Future<void> saveData(UserModel data) async {
    await UserRepo().saveData(data);
  }

  List<QueryDocumentSnapshot<UserModel>> _data = [];

  List<QueryDocumentSnapshot<UserModel>> get data => _data;

  Future<void> fetchData() async{
    try {
      final res = await UserRepo().getData();
      _data = res;
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    notifyListeners();
  }
}