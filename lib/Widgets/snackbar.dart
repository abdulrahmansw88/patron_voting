import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/utils/colors.dart';

void showSnackBar(String content) {
  Get.snackbar("Alert", content, backgroundColor: primaryColor, colorText: Colors.white);
}