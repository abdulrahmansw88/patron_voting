import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../characters/characters_screen.dart';
import '../helper/firebase_helper.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool saveLogin = false.obs;

  signInUser({int? userType}){
    signIn(email: email.text.toString(), password: password.text.toString(), userType: userType);
  }
}