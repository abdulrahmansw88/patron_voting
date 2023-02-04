import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/Widgets/snackbar.dart';
import '../Widgets/text_field.dart';
import '../utils/colors.dart';
import '../utils/validator_functions.dart';
import 'add_character_controller.dart';

class AddCharacterView extends StatelessWidget {
  AddCharacterView({Key? key}) : super(key: key);
  final controller = Get.put(AddCharacterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraint){
            return Container(
              padding:  EdgeInsets.symmetric(horizontal : constraint.maxWidth< 768?0.0 : 260, vertical : constraint.maxWidth< 768?0.0 : 80),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            const Text("Add Character", style: TextStyle(color: Color(0xFF00174c), fontSize: 26, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            const Text("Name", style: TextStyle(color: Color(0xFF7d9eb5), fontSize: 18)),
                            const SizedBox(height: 16),
                            AppTextField(
                              keyboardType: TextInputType.name,
                              validator: (value){
                                if(value!.isEmpty){
                                  return validateRequiredField(value, "Name");
                                }else if(value.length < 3){
                                  return "Enter a valid name";
                                }
                              },
                              textEditingController: controller.name,
                              border: true,
                            ),
                            const SizedBox(height: 16),
                            const Text("Image", style: TextStyle(color: Color(0xFF7d9eb5), fontSize: 18)),
                            const SizedBox(height: 8,),
                            Obx(()=>
                                GestureDetector(
                                  onTap: (){
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0)
                                    ),
                                    child: controller.image.value == ""?
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset("assets/images/img.png")) :
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(File(controller.image.value),width: Get.width - 40, height: 300,)),
                                  ),
                                )
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                color: primaryColor,
                                height: 45,
                                onPressed: (){
                                  if(controller.formKey.currentState!.validate()){
                                    if(controller.image.value ==""){
                                      showSnackBar("Please select Disny Image ");
                                    }else{
                                      controller.registerCharacterFS();
                                    }
                                  }
                                  // Get.to(()=> HomePageView());
                                }, child: const Text("Add Character", style: TextStyle(color: Colors.white, fontSize: 18) ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
