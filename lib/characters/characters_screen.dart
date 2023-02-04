import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/characters/character_controller.dart';
import 'package:patron_voting/helper/firebase_helper.dart';

class CharactersView extends StatelessWidget {
   CharactersView({Key? key}) : super(key: key);
  final controller = Get.put(CharacterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vote - Disny Characters"),
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
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 200,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(16.0),
                   boxShadow: [
                     BoxShadow(
                     offset: Offset(0, 2),
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(.5),
                ),
                ]
                 ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 110,
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child:Image.network("${snapshot.data!.docs[index]['imageUrl']}",fit: BoxFit.fitWidth,)),),
                      SizedBox(height: 10,),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Text("${snapshot.data!.docs[index]['name']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("${snapshot.data!.docs[index]['noOfVotes']} Votes",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          IconButton(onPressed: (){
                            voteCharacter("${snapshot.data!.docs[index].id}");
                          }, icon: Icon(Icons.front_hand_rounded, size: 40,))
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
        },
      ),
    );
  }
}