import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/model/Task.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/content_alert_update_delete.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';

Future showDialogBox2(BuildContext context, {required Tasks task, required TaskCategory category}) {

  final detailsHomeCubit = DetailsHomeCubit.get(context);

  return showDialog(context: context, builder: (context) {

    return

      BlocProvider.value(

        value: detailsHomeCubit,

        child: BlocListener<DetailsHomeCubit, DetailsHomeState>(

          listener: (context, state) {

            if (state is UpdateTaskFailed) {
              showToast(state.message, color:Colors.red);
            }
            if (state is UpdateTaskLoaded) {
              showToast(state.message, color:Colors.green);
            }
            if (state is DeleteTaskFailed) {
              showToast(state.message, color:Colors.red);
            }
            if (state is DeleteTaskSuccess) {
              showToast(state.message, color:Colors.red);
            }
          },

          child: AlertDialog(

            title: Center(
                child: Text("Task", style: Styles.LibreCaslonw600.copyWith(
                  color: Color(category.color1),
                  fontSize: 20.sp,
                ))
            ),
         content: CustomAlertDialogContentUpdateOrDelete(
           detailsHomeCubit: detailsHomeCubit,
           task: task,
           category: category,
         )
          )
            ),
      );
  }

  );
}

