import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';
import 'package:to_dolist_app/Features/HomeScreen/logic/home_cubit.dart';

class CustomContainerContent extends StatelessWidget {

 final TaskCategory category;

  const CustomContainerContent({super.key,required this.category});

  @override
  Widget build(BuildContext context) {

    return  Stack(

      children: [

 Positioned(top: 0,right: -2,child: (

     GestureDetector(

         onTap: (){

   HomeCubit.get(context).deleteCategory(category.id!);

    },child: Icon(Icons.remove_circle,color: Colors.white,size: 30.sp,)))),

        Center(child: Text(category.name, style: Styles.LibreCaslonw600.copyWith(
            fontWeight: FontWeight.w400,color: Colors.white),))
      ],
    );
  }
}
