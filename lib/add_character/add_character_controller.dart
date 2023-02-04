import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/firebase_helper.dart';

class AddCharacterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
   Rx<String> image = "".obs;

  RxBool obscurePassword = true.obs;

  registerCharacterFS(){
    Get.defaultDialog(
      title: "Loading",
      content: Text("Plaese wait loading"),
      barrierDismissible: false,
    );
    registerCharacter(name: name.text, path: image.value);
    clearController();
  }
  clearController(){
    name.text = "";
  }
  pickImage(){
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      image.value = value!.path;
    });
  }
}
