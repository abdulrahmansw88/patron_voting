import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsPopularity extends StatelessWidget {
  const ReportsPopularity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('votes').orderBy('timeStamp', descending: true) .snapshots(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(snapshot.data!.docs[index]['timeStamp'])
                    Text(snapshot.data!.docs[index]['timeStamp'].toString())
                    // SizedBox(
                    //   height: 110,
                    //   width: double.infinity,
                    //   child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //       child:Image.network("${snapshot.data!.docs[index]['imageUrl']}",fit: BoxFit.fitWidth,)),),
                    // SizedBox(height: 10,),
                    //
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 32.0),
                    //   child: Text("${snapshot.data!.docs[index]['name']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    // ),
                    // Padding(
                    //     padding: const EdgeInsets.only(left: 32.0),
                    //     child: Text("Total Votes : ${snapshot.data!.docs[index]['noOfVotes']}",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
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
