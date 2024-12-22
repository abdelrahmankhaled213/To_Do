import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';


class TaskFeatures extends StatelessWidget {

 final IconData icon;
  final String featureName;


  const TaskFeatures({super.key, required this.icon, required this.featureName});


  @override
  Widget build(BuildContext context) {
    return  Row(

        children: [

          Icon(icon, size: 30.h, color: Colors.black),

          Expanded(
            child: Text(featureName, style: Styles.LibreCaslonw600,textAlign: TextAlign.center,),
          ),
        ]
    );
  }
}
