import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';

class CustomPopMenuButton extends StatelessWidget {

  final  TaskCategory taskCategory;
  final DetailsHomeCubit detailsHomeCubit;

  const CustomPopMenuButton({super.key,required this.taskCategory,required this.detailsHomeCubit});

  @override
  Widget build(BuildContext context) {

    return
      Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors:
          [
            Color(taskCategory.color2),
            Color(taskCategory.color1),

          ]
        ),
        ),

        child: PopupMenuButton(



popUpAnimationStyle: AnimationStyle(
   curve: Curves.linear,
  duration: const Duration(
    seconds: 2
  ),
),

        itemBuilder: (context) {

          return [

            PopupMenuItem(


              child: const Text("Low"),
              onTap: () {
                detailsHomeCubit.taskPriority=TaskPriority.low;
                detailsHomeCubit.getTasks(taskCategory.id!);
              },
            ),
            PopupMenuItem(
              child: const Text("Medium"),
              onTap: (){
                detailsHomeCubit.taskPriority=TaskPriority.medium;
                detailsHomeCubit.getTasks(taskCategory.id!);
              },
            ),
            PopupMenuItem(
                child: const Text("High"),
                onTap: () {
                  detailsHomeCubit.taskPriority=TaskPriority.high;
                  detailsHomeCubit.getTasks(taskCategory.id!);
                }
            )

          ];

        }

        , icon:  Align
        (alignment: Alignment.topRight,
          child: Icon(Icons.more_vert,size: 15.sp,color: Colors.white,),
            ),
            ),
      );


  }
}
