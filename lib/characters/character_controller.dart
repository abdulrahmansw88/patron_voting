import 'package:get/get.dart';
import 'package:patron_voting/helper/firebase_helper.dart';

class CharacterController extends GetxController{

  void getCharacters(){
  var data =  getUser("character");
   print("Data in character \n =>  ${data}");
  }
  @override
  void onInit() {
    getCharacters();
    super.onInit();
  }
}