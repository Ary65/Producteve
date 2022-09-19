 
import 'package:flutter/material.dart';
import 'package:producteve/models/user_details_model.dart';
import 'package:producteve/resources/cloudfirestore_methods.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
