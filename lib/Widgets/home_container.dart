import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  ContainerWidget({
    super.key,
    this.text
  });
  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: Colors.grey.withOpacity(.5),
            ),
          ]
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text(text.toString(), style:const TextStyle(color: Color(0xFF00174c), fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}