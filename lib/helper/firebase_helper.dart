import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

registerUser({String? email, String? password})async{
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!
    ).then((value) {
      var user = UserData(
        name: "Zeeshan",
        email: "${value.user!.email}",
        password: "$password",
        uid: "${value.user!.uid}",
        role: 1,
      ).toMap();
      saveUserFS(data: user,collectionName: "user", uid: value.user!.uid);
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
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
  });
  } on FirebaseException catch(e){
    print("${e.message}");
  }catch (e){
    print("exception");
  }
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
getUserFromEmail(uid)async{
  var user = await db.collection('user').doc(uid).get();
  print("\n usre ------=>  ${user.data()}");
}
getUser() async {
  List<UserData> userData =  [];
  try{
    QuerySnapshot querySnapshot = await db.collection("users").get();
    final users = querySnapshot.docs.map((doc) => doc.data()).toList();
  }on FirebaseException catch(e){
    print("Exception Daata ${e.hashCode}");
  }
}