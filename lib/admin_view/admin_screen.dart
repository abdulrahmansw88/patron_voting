import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/admin_view/admin_controller.dart';
import 'package:patron_voting/admin_view/reports/line_chart_page.dart';
import 'package:patron_voting/admin_view/user_view.dart';
import 'package:patron_voting/home_screen/Home_View.dart';

import '../Widgets/dashboard_container.dart';
import 'character_view.dart';
import 'reports/report_view.dart';

class AdminView extends StatelessWidget {
   AdminView({Key? key}) : super(key: key);
  final controller = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: (){
            Get.offAll(()=>const HomeView());
          }, icon: Icon(Icons.logout)),
          IconButton(onPressed: (){
           controller.updateAdminPassword(context: context);
          }, icon: Icon(Icons.edit))
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
            title: "Reports",
            onTap: (){
              Get.to(()=>ReportsView());
            },
          ),
        ],
      ),
    );
  }
}
