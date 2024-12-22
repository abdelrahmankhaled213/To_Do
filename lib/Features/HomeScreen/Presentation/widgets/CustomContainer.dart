import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {

  final double height;
  final double width;
  final int color;
  final int color2;
  final Widget child;

  const CustomContainer({
    super.key,
    required this.height ,
    required this.width,
    required this.color,
    required this.color2,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: height,
      width:  width,
      decoration: BoxDecoration(

        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(color),
          Color(color2)
        ]),
         borderRadius: BorderRadius.circular(20.r),

      ),
      child: child,
    );
  }
}