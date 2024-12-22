
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';

class CustomDropButton extends StatefulWidget {

  final DetailsHomeCubit detailsHomeCubit;

  const CustomDropButton({super.key,required this.detailsHomeCubit});

  @override
  State<CustomDropButton> createState() => _CustomDropButtonState();
}

class _CustomDropButtonState extends State<CustomDropButton> {

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
      height: 50.h,

      child: DropdownButton(
borderRadius: BorderRadius.circular(15),

        items: widget.detailsHomeCubit.priorityList.map((e) =>

            DropdownMenuItem(
                value: e,
                child: Text(e))

        ).toList(),

        onChanged: (String? value) {

          setState(() {
            widget.detailsHomeCubit.taskPriority =
            widget.detailsHomeCubit.mapToTaskPriority[value]!;
            widget.detailsHomeCubit.initialPriority=value!;
          });

        },

        hint: Center(

          child: Text(
            widget.detailsHomeCubit.initialPriority, style: Styles.LibreCaslonw600.copyWith(
             fontSize: 20.sp)
            ,
          ),
        ),
      ),
    );
  }
}
