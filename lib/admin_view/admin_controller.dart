import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/Widgets/snackbar.dart';

import '../Widgets/text_field.dart';
import '../utils/colors.dart';
import '../utils/validator_functions.dart';

class AdminController extends GetxController{

  @override
  void onInit() async{
    var user = await FirebaseAuth.instance.currentUser;
    print(user);
    super.onInit();
  }

  updatePasswordUser(password)async{
    var user = await FirebaseAuth.instance.currentUser;
    try{
    user!.updatePassword("$password").then((value) {
      FirebaseFirestore.instance.collection('user').doc("${user.uid}").update({
        'password': "$password",
      });
      showSnackBar("Password updated successfully");
    });
    }on FirebaseException catch(e){
      showSnackBar("Errror");
    }
    showSnackBar("Password updated successfully");
    Get.back();
  }


  void updateAdminPassword({context}){
    final formKey = GlobalKey<FormState>();
    TextEditingController password = TextEditingController();
    showModalBottomSheet(context: context,
        enableDrag: true,
        useRootNavigator: true,
        builder: (BuildContext context){

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Update Admin Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 20,),
                  AppTextField(
                      border: true,
                      textEditingController: password,
                      labelText: "Password",
                      hintText: "Password",
                      validator:  (value){
                        if(value!.isEmpty){
                          return validateRequiredField(value, "Password");
                        }else if(value.length < 6){
                          return "Enter a valid Password";
                        }
                      }
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    color: primaryColor,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    minWidth: MediaQuery.of(context).size.width - 40,
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                       updatePasswordUser(password.text);
                      }
                    },
                    child: Text("Update", style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          );
        });
  }

}