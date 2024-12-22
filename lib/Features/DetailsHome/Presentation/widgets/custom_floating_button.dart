import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/model/Task.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/showDialogBox.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';

class CustomFloatingActionButton extends StatelessWidget {

  final TaskCategory taskCategory;

  final DetailsHomeCubit detailsHomeCubit;

  const CustomFloatingActionButton({super.key,required this.taskCategory,required this.detailsHomeCubit});

  @override
  Widget build(BuildContext context) {

    return  Container(

      height: 60.h, // Adjust to match FAB size
      width: 60.w,

      // Adjust to match FAB size

      decoration:  BoxDecoration(

        shape: BoxShape.circle,

        gradient:  LinearGradient(
          colors: [
            Color(taskCategory.color1)
            , Color(taskCategory.color2)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: FloatingActionButton(
        onPressed: () {
showDialogBox(
    context,()
async {
  if (detailsHomeCubit.formKey.currentState!.validate() &&  detailsHomeCubit.initialPriority!=" Please Select ") {
    await detailsHomeCubit.addTask(
        Tasks(
isRecycleBin: 0,
            isFav: 0,
            categoryId: taskCategory.id!,
priority: detailsHomeCubit.mapToTaskPriority2[detailsHomeCubit.taskPriority]!,
            date: detailsHomeCubit.date.text,
            title: detailsHomeCubit.taskText.text
        )
    );

    Navigator.pop(context);
    await detailsHomeCubit.getTasks(taskCategory.id!);
  }
}
);

    },

        backgroundColor: Colors.transparent, // Makes the button's background transparent
        elevation: 0, // Removes shadow
        child: Icon(Icons.add,color: Colors.white,size: 20.sp,),
      ),
    );
  }
}

