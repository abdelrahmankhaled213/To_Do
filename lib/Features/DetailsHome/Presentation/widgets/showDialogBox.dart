import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_alert_dialog_content.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';

Future showDialogBox(BuildContext context, void Function() onPressed) {

  final detailsHomeCubit = DetailsHomeCubit.get(context);

  return showDialog(context: context, builder: (context) {

    return BlocProvider.value(

      value: detailsHomeCubit,

      child: AlertDialog(

          title: const Text("Add Task"),

          titleTextStyle: Styles.LibreCaslonw600,

          content: const CustomAlertDialogInsert(),
          actions: [

            BlocListener<DetailsHomeCubit,DetailsHomeState >(

              listener: (context, state) {

             if(state is InsertTaskLoaded){

                  showToast(state.message, color:Colors.green);
                }
                if(state is InsertTaskFailed){

                  showToast(state.message, color:Colors.red);
                }
              },
              child: TextButton(

                  onPressed: onPressed,

                  child: Text(
                    "Submit"
                    , style: Styles.LibreCaslonw600.copyWith
                    (color: Colors.black, fontSize: 20.sp),
                  )
              ),
            ),
          ]
      ),
    );
  }
  );
}
