import 'package:flutter/material.dart';

import '../Widgets/text_field.dart';
import '../helper/firebase_helper.dart';
import '../utils/colors.dart';
import '../utils/validator_functions.dart';

handleClickCharacter({String? value, context, imageUrl, documentId, noOfVotes, name}) {
  switch (value) {
    case 'Delete':
      print("delete");
      deleteFS(documentId);
      break;
    case 'Update':
      updateCharacterData(context: context, imageUrl: imageUrl, noOfVotes: noOfVotes, name: name);
      break;
  }
}

void updateCharacterData({context, imageUrl, name, noOfVotes, documentId}){
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
                    child: Text("Update Character", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
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
                MaterialButton(
                  color: primaryColor,
                  height: 50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  minWidth: MediaQuery.of(context).size.width - 40,
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      updateCharacterFS(documentId, {
                        "name": name.text,
                        "noOfVotes": noOfVotes,
                        "imageUrl": imageUrl,
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