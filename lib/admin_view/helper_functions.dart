import 'package:flutter/material.dart';
import 'package:patron_voting/utils/colors.dart';
import '../Widgets/text_field.dart';
import '../helper/firebase_helper.dart';
import '../utils/validator_functions.dart';

handleClick({String? value, context, documentId, password, role, uid}) {
  switch (value) {
    case 'Delete':
      print("delete");
      deleteFS(documentId);
      break;
    case 'Update':
      updateData(context: context, documentId: documentId, password: password, role: role, uid: uid);
      break;
  }
}
void updateData({context, documentId, password, role, uid}){
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
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
                child: Text("Update User", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 20,),
            AppTextField(
                border: true,
                textEditingController: name,
                labelText: "Name",
                hintText: "Email",
                validator:  (value){
                  if(value!.isEmpty){
                    return validateRequiredField(value, "Name");
                  }else if(value.length < 3){
                    return "Enter a valid name";
                  }
                }
            ),
            SizedBox(height: 20),
            AppTextField(
                border: true,
                textEditingController: email,
                labelText: "Email",
                hintText: "Email",
                validator: (value){
                  if(value!.isEmpty){
                    return validateRequiredField(value, "Email");
                  }else if(!validateEmail(value)){
                    return "Invalid Email Address";
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
                  updateUserFS(documentId, {
                    "name": name.text,
                    "email": email.text,
                    "password": password,
                    "role": role,
                    "uid" : uid,
                  });
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