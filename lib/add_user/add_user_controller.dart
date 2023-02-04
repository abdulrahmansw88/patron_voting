import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/helper/firebase_helper.dart';

class AddUserController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool obscurePassword = true.obs;

  registerUserFS(){
    Get.defaultDialog(
      title: "Loading",
      content: Text("Plaese wait loading"),
      barrierDismissible: false,
    );
    registerUser(email: email.text, password: password.text, name: name.text);
    clearController();
  }
  clearController(){
    name.text = "";
    email.text = "";
    password.text = "";
  }
}