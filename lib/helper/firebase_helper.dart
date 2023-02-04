import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:patron_voting/Widgets/snackbar.dart';
import 'package:patron_voting/Widgets/success_dialog.dart';
import 'package:patron_voting/admin_view/admin_screen.dart';
import 'package:patron_voting/enums/user_roles.dart';
import 'package:patron_voting/models/character.dart';
import 'package:patron_voting/models/user.dart';
import 'package:patron_voting/role_login/login_view.dart';

import '../characters/characters_screen.dart';

void signIn({String? email, String? password, int? userType})async{
  try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "$email",
        password: "${password}"
    ).then((value) {
      print(" nouser _______\n: $value");
      getUserFromEmail(uid: value.user!.uid, usertTpye: userType);
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Get.back();
      showSnackBar("No user found for that email");
      print('No user found for that email.');

    } else if (e.code == 'wrong-password') {
      Get.back();
      showSnackBar("Invalid email/password");
      print('Invalid email/password');
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
registerCharacter({String? path, String? name})async{
  try {
      addCharacter(name: name,filePath: path, noOfVotes: 0);
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


addCharacter({String? filePath, String? name, int?  noOfVotes}) async {
  try{

    Reference ref = FirebaseStorage.instance
        .ref().child("Characters-$name");

    UploadTask uploadTask = ref.putFile(File("$filePath"));
   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(()async {
     String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
     var character = Character(
       name: name,
       imageUrl: imageUrl,
       noOfVotes: noOfVotes,
     ).toMap();
     db.collection("characters").add(character).then((DocumentReference doc) {
       Get.back();
       showSnackBar("Added Successfully");
     }
     );
   });

  }on FirebaseException catch(e){
    Get.back();
    showSnackBar("${e.message}");
  }
}

voteCharacter(documentId){
  db.collection('characters').doc("$documentId").update({
      'noOfVotes': FieldValue.increment(1),
  });
  Map<String, dynamic> data = {
    "characterId": "$documentId",
    "voterId": "",
    "timeStamp":Timestamp.now(),
  };
  var fieldName = "${Timestamp.now().toDate().microsecondsSinceEpoch}";
  db.collection('votes').doc(fieldName).set(data);
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
updateCharacterFS(documentId, Map<String, dynamic> data){
  try{
    db.collection("characters").doc(documentId).set(data).then((value) {
      showSnackBar("Successfully Updated !");
    });
  }on FirebaseException catch(e){
    showSnackBar("Update Failed!");
  }
}
deleteCharacter(documentId){
  try{
    db.collection("characters").doc(documentId).delete().then((value) {
      showSnackBar("Character Deleted !");
    });
  }on FirebaseException catch(e){
    showSnackBar("Delete Failed");
  }
}
getUserFromEmail({uid, usertTpye})async{
  try{
   await db.collection('user').doc(uid).get().then((value) {
    // print("Signed -----In\n _____\n _____________-\n  ${value["role"]}");
    if(value.isBlank!){
      showSnackBar("User not registered");
    }else if(value['role'] != usertTpye){
      String role = usertTpye == 1 ? "Admin" : "User";
      Get.back();
      showSnackBar("Email not registered for $role");
    } else if(value['role'] == 2){
      Get.to(CharactersView());
      print("User");
    }else if(value['role'] == 1){
      Get.offAll(()=> AdminView());
      print("Admin");
    }
    print("Signed -----In\n _____\n _____________-\n  ${value.data()}");
  });
  }on FirebaseException catch(e){
    showSnackBar("Invalid Credentials ${e.message}");
    Get.back();
  }
  // print("useer________________-\n $user");
  // print("\n usre ------=>  ${user.data()}");
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