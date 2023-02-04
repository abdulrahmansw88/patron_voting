import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/Widgets/text_field.dart';
import 'package:patron_voting/add_user/add_user.dart';
import 'package:patron_voting/admin_view/helper_functions.dart';
import 'package:patron_voting/helper/firebase_helper.dart';

import '../utils/colors.dart';
import '../utils/validator_functions.dart';

class UserViewAdmin extends StatefulWidget {
   UserViewAdmin({Key? key}) : super(key: key);

  @override
  State<UserViewAdmin> createState() => _UserViewAdminState();
}

class _UserViewAdminState extends State<UserViewAdmin> {
  String name="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  TextField(
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search), hintText: 'Users'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot){
          if(snapshot.isBlank!){
            return Center(child: Text("No Data avaialable"));
          }else if(!snapshot.hasData){
            return Center(child: Text("Loading"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index){
              return name.isEmpty ? buildListTile(snapshot, index, context) : snapshot.data!.docs[index]['name']
                  .toString()
                  .toLowerCase()
                  .startsWith(name.toLowerCase()) ?  buildListTile(snapshot, index, context) : Text('');
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: Get.width - 40,
        height: 55,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          onPressed: () {
            Get.to(AddUser());
          },
          backgroundColor: primaryColor,
          label: const Text("Add User", style: TextStyle(color: Colors.white),),
          isExtended: true,
        ),
      ),
    );
  }

  Widget buildListTile(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index, BuildContext context) {
    return snapshot.data!.docs[index]['role'] == 1? Container() :ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              title: Row(
                children: [
                  Text("${snapshot.data!.docs[index]['name']}"),
                  SizedBox(width: 6,),
                ],
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/images/img.png'),
                    image:  NetworkImage("https://i.pravatar.cc/"),
                    fit: BoxFit.cover,
                  ),

                  // Image.network("https://i.pravatar.cc/")
              ),
              trailing:  PopupMenuButton<String>(
                onSelected: (value){
                  if(value == "Update") {
                    handleClick(context: context,
                        uid: snapshot.data!.docs[index]['uid'],
                        role: snapshot.data!.docs[index]['role'],
                        password: snapshot.data!.docs[index]['password'],
                        documentId: snapshot.data!.docs[index].id,
                        value: "Update");
                  }else if(value =="Delete"){
                    deleteFS(snapshot.data!.docs[index].id);
                  }
                  },
                itemBuilder: (BuildContext context) {
                  return {'Update', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            );
  }
}

