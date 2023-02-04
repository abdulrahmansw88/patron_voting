import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularCharacterController extends GetxController with StateMixin{
  List noOfVotes = [];
  List<Map> popularData =[];
  List<Color> colorData =[
    Colors.redAccent,
    Colors.yellow,
    Colors.lightGreen,
    Colors.cyan,
    Colors.teal,
  ];
  @override
  void onInit() {
    FirebaseFirestore.instance.collection('characters').orderBy('noOfVotes', descending: true).get().then((value) {
      List.generate(value.docs.length>5 ? 5 : value.docs.length, (index)  {
        print("${value.docs[index]["noOfVotes"]}");
        noOfVotes.add(value.docs[index]["noOfVotes"]);
        popularData.add({
              "name": "${value.docs[index]["name"]}",
              "noOfVotes": "${value.docs[index]["noOfVotes"]}",
            }
        );
        change(null, status: RxStatus.success());
      });
    });

    super.onInit();
  }
}