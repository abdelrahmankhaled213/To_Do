import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/custom_circle_avatar.dart';

class CustomListViewBuilder extends StatelessWidget {

  final List<Color>colorsList;
  final Function(int index) onTap;
  final int currentIndex;
  const CustomListViewBuilder({required this.currentIndex,required this.colorsList,required this.onTap ,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        cacheExtent: 100,
        scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
        return  CustomCircleAvatar(

          onTap: ()=>onTap(index),

          isChecked: index==currentIndex,

          color: colorsList[index],
        );
      }, separatorBuilder: (context, index) => SizedBox(width: 8.w)
        , itemCount: colorsList.length,shrinkWrap: true,),
    );
  }
}