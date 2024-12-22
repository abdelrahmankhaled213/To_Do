import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/model/Task.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_alert_dialog_content.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';

class CustomAlertDialogContentUpdateOrDelete extends StatelessWidget {

  final Tasks task;
  final DetailsHomeCubit detailsHomeCubit;
  final TaskCategory category;

  const CustomAlertDialogContentUpdateOrDelete ({super.key,required this.category,required this.detailsHomeCubit, required this.task});

  @override
  Widget build(BuildContext context) {
    return  Row(

      children: [

        Expanded(
          child: TextButton(
            onPressed: () {


              showUpdateTask(

              buildCXT: context, onPressed: () async{

if(detailsHomeCubit.formKey.currentState!.validate()){

  if (task ==
      task.copyWith(
        categoryId: category.id,
        title: detailsHomeCubit.taskText.text,
        date: detailsHomeCubit.date.text,
        priority: detailsHomeCubit.mapToTaskPriority2[detailsHomeCubit.taskPriority]!,
      )) {
    showToast("Nothing Changed", color:Colors.red);
  }

  else {
    await  detailsHomeCubit.updateTask(
        task.copyWith(
          categoryId: category.id,
          title: detailsHomeCubit.taskText.text,
          date: detailsHomeCubit.date.text,
          priority: detailsHomeCubit.mapToTaskPriority2[detailsHomeCubit.taskPriority]!,
        )
    );

   await detailsHomeCubit.getTasks(category.id!);

    Navigator.pop(context);
  }
}



              }
              );
            },
            child: Text("Update"
                , style: Styles.LibreCaslonw600.copyWith(
                  fontSize: 20.sp,
                  color: Color(category.color1),
                )
            ),
          ),
        ),

        Expanded(

          child: TextButton(

            onPressed: () async {

             await  detailsHomeCubit.deleteTask(
                 task.copyWith(
                 isRecycleBin: 1
               )
             );

             await detailsHomeCubit.getTasks(category.id!);

             Navigator.pop(context);

             },
            child: Text("Delete"
                , style: Styles.LibreCaslonw600.copyWith(
                  fontSize: 20.sp,
                  color: Color(category.color2),
                )
            ),
          ),
        ),
      ],
    );
  }
}
showUpdateTask({required BuildContext buildCXT, required void Function() onPressed}) {

  final detailsHomeCubit=DetailsHomeCubit.get(buildCXT);

return showDialog(context: buildCXT, builder: (context){

  return BlocProvider.value(


    value: detailsHomeCubit,

  child: AlertDialog(

title: const Text("Update Task"),

  titleTextStyle: Styles.LibreCaslonw600,

  content: const CustomAlertDialogInsert(),

  actions: [
  TextButton(
  onPressed: onPressed,
  child: Text("Submit"
  , style: Styles.LibreCaslonw600.copyWith
  (color: Colors.black, fontSize: 20.sp),
  )
  ),
  ],
  ),
);
}
);

}