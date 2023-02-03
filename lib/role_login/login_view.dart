import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/enums/user_roles.dart';
import 'package:patron_voting/role_login/login_controller.dart';
import 'package:patron_voting/utils/validator_functions.dart';

import '../Widgets/text_field.dart';
import '../utils/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, this.userRoles}) : super(key: key);
final controller = Get.put(LoginController());
UserRoles? userRoles;
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("Patron Voting ${returnUserRole(userRoles!.index)}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
                      height: 200,
                      decoration:const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                      ),
                    ),
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
                            const Text("Login", style: TextStyle(color: Color(0xFF00174c), fontSize: 26, fontWeight: FontWeight.bold)),
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
                            SizedBox(height: 10),
                            Obx(()=> CheckboxListTile(
                              title: const Text("Save Login"),
                              onChanged: (value){
                                controller.saveLogin.value = value!;
                              },
                              value: controller.saveLogin.value,
                            ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                color:primaryColor,
                                height: 45,
                                onPressed: (){
                                  if(controller.formKey.currentState!.validate()){
                                    controller.signInUser();
                                  }
                                  // Get.to(()=> HomePageView());
                                }, child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18) ),),
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
