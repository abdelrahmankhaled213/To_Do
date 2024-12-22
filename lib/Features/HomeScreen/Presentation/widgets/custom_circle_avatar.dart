import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleAvatar extends StatelessWidget {

  final Color color;
  final bool isChecked;
  final VoidCallback onTap;

  const CustomCircleAvatar({required this.onTap,required this.color,required this.isChecked,super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(

        alignment: Alignment.center,
        children: [

          GestureDetector(
            onTap: onTap,

            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: color,
            ),
          ),
          Icon( isChecked?Icons.check_sharp:null,color: Colors.white,)
        ] );
  }
}