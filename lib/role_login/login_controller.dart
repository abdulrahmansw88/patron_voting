import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../characters/characters_screen.dart';
import '../helper/firebase_helper.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController(text: "adeel@gk.com");
  TextEditingController password = TextEditingController(text: "123456");
  RxBool obscurePassword = true.obs;
  RxBool saveLogin = false.obs;

  signInUser(){
    signIn(email: email.text.toString(), password: password.text.toString());
    Get.to(CharactersView());
  }
}