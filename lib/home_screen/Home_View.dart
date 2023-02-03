import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          GestureDetector(
            child: ContainerWidget(text: "Admin Login"),
            onTap: (){
              Get.to(()=> LoginScreen(userRoles: UserRoles.admin));
            },
          ),
          GestureDetector(
            child: ContainerWidget(text: "User Login",),
            onTap: (){
              registerUser(email: "adeel@gk.com", password: "123456");
              // Get.to(()=> LoginScreen(userRoles: UserRoles.user));
            },
          ),
        ],
      ),
    );
  }
}


