import 'package:flutter/material.dart';

showAppDialog(context, [String? heading, String? paragraph, String? buttonLabel]){
  showDialog(context: context,builder: (BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *.12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("$heading",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const  SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Text("$paragraph", textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              Align(
                // alignment: Alignment.center,
                child: SizedBox(
                  width: 320.0,
                  child: GestureDetector(
                    // color: Color(0xFFA1d3ff),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  Text(
                      "$buttonLabel",
                      textAlign: TextAlign.center,
                      style:const TextStyle(color:Color(0xFFA1d3ff), fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  });
}