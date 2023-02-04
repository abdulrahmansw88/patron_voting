import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/admin_view/user_view.dart';

import '../Widgets/dashboard_container.dart';
import 'character_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.logout))
        ],
      ),
      body: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 12),
          crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: [
          DashBoardContainer(
            title: "User",
            onTap: (){
              Get.to(UserViewAdmin());
            },
          ),
          DashBoardContainer(
            title: "Character",
            onTap: (){
              Get.to(CharacterViewAdmin());
            },
          ),
          DashBoardContainer(
            title: "Popularity",
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
