import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future successDialog()async {
  Get.dialog(
    Column(
      children: [
        Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/checked.gif", scale:8,
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("Added", textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Align(
                  // alignment: Alignment.center,
                  child: SizedBox(
                    width: 320.0,
                    child: GestureDetector(
                      // color: Color(0xFFA1d3ff),
                      onTap: () {
                        Get.back();
                      },
                      child:  const Text(
                        "The Address has been added",
                        textAlign: TextAlign.center,
                        style:TextStyle(color:Colors.white,  fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}