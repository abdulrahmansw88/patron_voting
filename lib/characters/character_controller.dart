import 'package:get/get.dart';
import 'package:patron_voting/helper/firebase_helper.dart';

class CharacterController extends GetxController{

  void getCharacters(){
   List data =  getUser("character");
   print("Data in character \n =>  ${data[0]}");
  }
  @override
  void onInit() {
    getCharacters();
    super.onInit();
  }
}