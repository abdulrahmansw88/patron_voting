import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/add_character/add_character.dart';

import '../characters/helper_methods.dart';
import '../helper/firebase_helper.dart';
import '../utils/colors.dart';

class CharacterViewAdmin extends StatefulWidget {
   CharacterViewAdmin({Key? key}) : super(key: key);

  @override
  State<CharacterViewAdmin> createState() => _CharacterViewAdminState();
}

class _CharacterViewAdminState extends State<CharacterViewAdmin> {
  String name='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search), hintText: 'Characters'),
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('characters').snapshots(),
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
              return name.isEmpty ? buildListTile(snapshot, index, context):  snapshot.data!.docs[index]['name']
                  .toString()
                  .toLowerCase()
                  .startsWith(name.toLowerCase()) ? buildListTile(snapshot, index, context) : Text("");
            },
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: Get.width - 40,
        height: 55,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          onPressed: () {
            Get.to(()=>AddCharacterView());
          },
          backgroundColor: primaryColor,
          label: const Text("Add Character", style: TextStyle(color: Colors.white),),
          isExtended: true,
        ),
      ),
    );
  }

  ListTile buildListTile(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index, BuildContext context) {
    return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              title: Text("${snapshot.data!.docs[index]['name']}"),
              subtitle: Text("Total Votes ${snapshot.data!.docs[index]['noOfVotes']}"),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child:  FadeInImage(
                  placeholder: AssetImage('assets/images/img.png'),
                  image:  NetworkImage("${snapshot.data!.docs[index]['imageUrl']}",),
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              trailing:  PopupMenuButton<String>(
                onSelected: (value){
                  if(value == "Update") {
                    // handleClick(context: context,
                    //     uid: snapshot.data!.docs[index]['uid'],
                    //     role: snapshot.data!.docs[index]['role'],
                    //     password: snapshot.data!.docs[index]['password'],
                    //     documentId: snapshot.data!.docs[index].id,
                    //     value: "Update");
                    updateCharacterData(
                      context: context,
                      name: snapshot.data!.docs[index]['name'],
                      imageUrl: snapshot.data!.docs[index]['imageUrl'],
                      noOfVotes: snapshot.data!.docs[index]['noOfVotes'],
                      documentId: snapshot.data!.docs[index].id,
                    );
                  }else if(value =="Delete"){
                    deleteCharacter(snapshot.data!.docs[index].id);
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
