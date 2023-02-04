import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/admin_view/admin_screen.dart';
import 'package:patron_voting/enums/user_roles.dart';

import '../Widgets/home_container.dart';
import '../helper/firebase_helper.dart';
import '../role_login/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child:  Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("Select Role", style: TextStyle(color: Color(0xFF00174c), fontSize: 26, fontWeight: FontWeight.w600)),
              )),
          GestureDetector(
            child: ContainerWidget(text: "Admin",),
            onTap: (){
              Get.to(()=> LoginScreen(userRoles: UserRoles.admin));
            },
          ),
          GestureDetector(
            child: ContainerWidget(text: "User",),
            onTap: (){
              Get.to(()=> LoginScreen(userRoles: UserRoles.user));
            },
          ),
        ],
      ),
    );
  }
}


