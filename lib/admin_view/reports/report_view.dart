import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/Widgets/dashboard_container.dart';
import 'package:patron_voting/admin_view/reports/line_chart_page.dart';
import 'package:patron_voting/admin_view/reports/popular_characters.dart';
import 'package:patron_voting/admin_view/reports/reports_controller.dart';
import 'package:patron_voting/admin_view/reports/reports_popularity.dart';
import 'package:patron_voting/admin_view/reports/votes_per_character.dart';

class ReportsView extends StatelessWidget {
   ReportsView({Key? key}) : super(key: key);
  final controller = Get.put(ReportsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 10),
          crossAxisCount: 2,
        crossAxisSpacing:16,
       mainAxisSpacing: 8,
       children: [
          Obx(()=> DashBoardContainer(title: "${controller.todayVotes.value}\n Today Votes")),
          DashBoardContainer(
            title: "Top 5 Characters",
            onTap: (){
              Get.to(()=> PopularCharacters());
            },
          ),

         DashBoardContainer(
           title: "Character Votes",
           onTap: (){
             Get.to(()=> VotesPerCharacters());
           },
         ),

         DashBoardContainer(
           title: "Popularity",
           onTap: (){
             Get.to(()=> LineChartPage());
           },
         ),
        ],
      ),
    );
  }
}
