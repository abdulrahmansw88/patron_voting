import 'package:flutter/material.dart';

class DashBoardContainer extends StatelessWidget {
  DashBoardContainer({
    Key? key,
    this.onTap,
    required this.title,
  }) : super(key: key);
  void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 94,
        height: 60,
        decoration:  BoxDecoration(
          borderRadius:  BorderRadius.all(
              Radius.circular(16),
          ),
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                color: Colors.grey.withOpacity(.5),
              ),
            ]
        ),
        child: Center(
          child: Text(
              title,
              style: const TextStyle(
                  color:   Color(0xff474747),
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0
              ),
              textAlign: TextAlign.center
          ),
        ),
      ),
    );
  }
}