import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/firebase_helper.dart';
import '../utils/colors.dart';

class CharacterViewAdmin extends StatelessWidget {
  const CharacterViewAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Character"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('characters').snapshots(),
        builder: (context, snapshot){
          if(snapshot.isBlank!){
            return Text("No Data avaialable");
          }else if(!snapshot.hasData){
            return Text("Loading");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index){
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                title: Text("${snapshot.data!.docs[index]['name']}"),
                subtitle: Text("Total Votes ${snapshot.data!.docs[index]['noOfVotes']}"),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/images/img.png'),
                    image:  NetworkImage("https://i.pravatar.cc/"),
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
                    }else if(value =="Delete"){
                      // deleteFS(snapshot.data!.docs[index].id);
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
            // Get.to(AddUser());
          },
          backgroundColor: primaryColor,
          label: const Text("Add Character", style: TextStyle(color: Colors.white),),
          isExtended: true,
        ),
      ),
    );
  }
}
