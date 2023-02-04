import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:patron_voting/Widgets/snackbar.dart';
import 'package:patron_voting/Widgets/success_dialog.dart';
import 'package:patron_voting/enums/user_roles.dart';
import 'package:patron_voting/models/character.dart';
import 'package:patron_voting/models/user.dart';

void signIn({String? email, String? password})async{
  try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "$email",
        password: "${password}"
    ).then((value) {
      print(value);
      getUserFromEmail(value.user!.uid);
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

registerUser({String? email, String? password, String? name})async{
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!
    ).then((value) {
      var user = UserData(
        name: name,
        email: value.user!.email,
        password: password,
        uid: value.user!.uid,
        role: UserRoles.user.index,
      ).toMap();
      saveUserFS(data: user,collectionName: "user", uid: value.user!.uid);
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      showSnackBar("Weak Password");
      Get.back();
    } else if (e.code == 'email-already-in-use') {
      Get.back();
      showSnackBar("The account already exists for that email.");
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
saveUserFS({data, String? collectionName, String? uid}){
  try{
  db.collection(collectionName!).doc(uid).set(data).then((value) {
    print("Successfully added user");
    Get.back();
    showSnackBar("Added Successfully");
  });
  } on FirebaseException catch(e){
    print("${e.message}");
  }catch (e){
    showSnackBar("Error ! unable to add user");
    print("exception");
  }
}

searchUser(query){
  var data = db.collection("user").where("name", arrayContains: query).get();
  print("Search data____________________________________\n");
  // data.then((value) {
  //   print(value.docs[0]['name']);
  // });
}

addCharacter(String? filePath) async {
  try{

    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance
        .ref().child("Characters-Images");

    uploadTask = ref.putFile(File("$filePath"));

    String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
    print(imageUrl);
    Map character = Character(
      name: "Zeeshan",
      imageUrl: "$imageUrl",
      noOfVotes: 1,
    ).toMap();
    // saveUserFS(character, "characters", "uid");
    //
    // db.collection("characters").add(character).then((DocumentReference doc) =>
    //     print('Document Snapshot added with ID: ${doc.id}'));
  }on FirebaseException catch(e){
    print("Exception Data ${e}");
  }
}

voteCharacter(documentId){
// var increment = db.doc("character").firestore.f

  FirebaseFirestore.instance.collection('characters').doc("$documentId").update({
      'noOfVotes': FieldValue.increment(1),
  });
  SetOptions(merge:true);
}

updateUserFS(documentId, Map<String, dynamic> data){
  try{
  db.collection("user").doc(documentId).set(data).then((value) {
    showSnackBar("Successfully Updated Data!");
  });
}on FirebaseException catch(e){
showSnackBar("Update Failed!");
}
}

deleteFS(documentId){
  try{
  db.collection("user").doc(documentId).delete().then((value) {
    showSnackBar("User Deleted");
  });
  }on FirebaseException catch(e){
    showSnackBar("Delete Failed");
  }
}
getUserFromEmail(uid)async{
  var user = await db.collection('user').doc(uid).get();
  print("\n usre ------=>  ${user.data()}");
}
getUser(collectionName) async {
  List<UserData>? userData ;
  try{
    QuerySnapshot querySnapshot = await db.collection("${collectionName}").get();
    final users = querySnapshot.docs.map((doc) => (doc.data()));
    print("user \n ${users}");
    // UserData.fromFirestore(users, null);
    // UserData.fromMap(users);
    return users;
  }on FirebaseException catch(e){
    print("Exception Daata ${e.hashCode}");
  }
}