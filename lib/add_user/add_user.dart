import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/add_user/add_user_controller.dart';
import 'package:patron_voting/utils/colors.dart';

import '../Widgets/text_field.dart';
import '../utils/validator_functions.dart';

class AddUser extends StatelessWidget {
   AddUser({Key? key}) : super(key: key);
  final controller = Get.put(AddUserController());
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
                      const Text("Register User", style: TextStyle(color: Color(0xFF00174c), fontSize: 26, fontWeight: FontWeight.bold)),
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
                      const Text("Email", style: TextStyle(color: Color(0xFF7d9eb5), fontSize: 18)),
                      const SizedBox(height: 6),
                      AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return validateRequiredField(value, "Email");
                          }else if(!validateEmail(value)){
                            return "Invalid Email Address";
                          }
                        },
                        textEditingController: controller.email,
                        border: true,
                      ),
                      const SizedBox(height: 16),
                      const Text("Password", style: TextStyle(color: Color(0xFF7d9eb5), fontSize: 18)),
                      const SizedBox(height: 8,),
                      Obx(()=>
                          AppTextField(
                            keyboardType: TextInputType.visiblePassword,
                            textEditingController: controller.password,
                            obscureText: controller.obscurePassword.value,
                            border: true,
                            validator: (value){
                              if(value!.isEmpty){
                                return validateRequiredField(value, "Password");
                              }else if(value.length < 6){
                                return "Password length must be at least 6 characters long";
                              }
                            },
                            suffixIcon: IconButton(
                              onPressed: (){
                                controller.obscurePassword.value = !controller.obscurePassword.value;
                                print("${controller.obscurePassword.value}");
                              },
                              icon: Icon(controller.obscurePassword.value ? Icons.password : Icons.remove_red_eye),
                            ),
                          ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 30,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          color:primaryColor,
                          height: 45,
                          onPressed: (){
                            if(controller.formKey.currentState!.validate()){
                              controller.registerUserFS();
                            }
                            // Get.to(()=> HomePageView());
                          }, child: const Text("Add User", style: TextStyle(color: Colors.white, fontSize: 18) ),),
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
