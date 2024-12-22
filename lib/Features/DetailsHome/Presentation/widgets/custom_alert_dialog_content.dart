import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/views/details_home_screen.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/customDropDow.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_text_form.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';

class CustomAlertDialogInsert extends StatelessWidget {

  const CustomAlertDialogInsert({super.key});

  @override

  Widget build(BuildContext context) {

    final detailsHomeCubit = DetailsHomeCubit.get(context);
    final timeStamp=TimeOfDay.now();
    final dateTimeNow=DateTime.now();


    return  Form(

      key: detailsHomeCubit.formKey,

      child: Column
        (
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(hint: "Enter Task"
              , controller: detailsHomeCubit.taskText,
              validator: (value) => validate(value,msg: "Please Enter Task"),
            ),
            CustomTextFormField(

                validator: (value) =>
                    validate(value, msg: "Please Enter Date"),

                node: AlwaysDisabledFocusNode(),
                controller: detailsHomeCubit.date,
                hint: "Enter Date",
                iconButton: IconButton(
                  onPressed: () {
                  showDatePicker(
                      context: context,

                      firstDate: DateTime(dateTimeNow.year),
                      lastDate: DateTime(
                          dateTimeNow.year + 1),

                      initialDate: dateTimeNow
                  ).
                  then((value) {

                    detailsHomeCubit.date.text = DateFormat('yMMMd')
                        .format(value!)
                        .toString();
                  });
                },
                  icon: const Icon(Icons.calendar_today),
                 )
            ),

            CustomTextFormField(

                validator: (value) => validate(value, msg: "Please Enter Time"),

                node: AlwaysDisabledFocusNode(),

                iconButton: IconButton(

                  onPressed: () async {
                    await showTimePicker(
                        builder: (context, child) {
                          return customThemeTimePicker(child);
                        },

                        barrierColor: Colors.black12,
                        context: context,
                        initialTime: timeStamp
                    ) .then((value) {
                      detailsHomeCubit.time.text = value!.format(context).toString();
                    });
                  },

                  icon: const Icon(Icons.alarm),

                ), hint: "Enter Time",
                controller: detailsHomeCubit.time),

            CustomDropButton(detailsHomeCubit: detailsHomeCubit)

          ]
      ),
    );
  }
}
