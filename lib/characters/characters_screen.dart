import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/characters/character_controller.dart';

class CharactersView extends StatelessWidget {
   CharactersView({Key? key}) : super(key: key);
  final controller = Get.put(CharacterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:const [
          Text("Candidates"),
        ],
      ),
    );
  }
}