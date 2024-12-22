import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContainer.dart';
import 'package:to_dolist_app/Features/TaskDate/logic/date_cubit.dart';
import 'package:to_dolist_app/Features/TaskDate/presentation/widgets/isFav_today.dart';

class TodayScreenView extends StatelessWidget {

  const TodayScreenView({ super.key});

  @override
  Widget build(BuildContext context) {

    final dateCubit = DateCubit.get(context);

    return Scaffold(

        body: BlocBuilder<DateCubit, DateState>(

            builder: (BuildContext context, state) {

              if (state is GetTodayLoading) {
                return const Center(

                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }

              else if (state is GetTodayLoaded) {

                return SafeArea(

                    child:

                   state.taskList.isEmpty ?  buildNoTaskInThatDay(): ListView.separated(

                        separatorBuilder: (context, index) =>

                            SizedBox(
                              height: 5.h,
                            ),

                        itemCount: state.taskList.length,

                        itemBuilder: (context, i) {

                          return Padding(

                            padding: EdgeInsets.symmetric(

                              horizontal: 10.w,

                              vertical: 10.h,
                            ),

                            child: Stack(

                                children: [

                                  CustomContainer(height: 200.h
                                      ,
                                      width: double.infinity,
                                      color: state.taskList[i].color1,
                                      color2: state.taskList[i].color2,
                                      child: buildRow(state, i)
                                  ),

                                  Positioned(
                                      top: 2,
                                      right: 0,
                                      child: IsFavorite(
                                        dateCubit: dateCubit,
                                        today: state.taskList[i],
                                      )
                                  )
                                ]
                            ),
                          );
                        }
                    )
                );
              }

              else if (state is GetTodayError) {
                return Center(
                    child: Text(state.errorMsg)
                );
              }

              return const SizedBox.shrink();
            }

        )
    );
  }


}

Widget buildRow(GetTodayLoaded state, int i) {

  return SizedBox(
    width: double.infinity,
    height: 100,
    child: Center(
      child: Text(
        "Task Content : ${state.taskList[i].title}",
        style: Styles.LibreCaslonw600.copyWith(fontSize: 18.sp,
            color: Colors.white),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,


      ),
    ),
  );
}





buildNoTaskInThatDay(){

  return Column(
mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/image/no-content (1).png",
          ),
        ),
        Text("No Tasks Today ",style:Styles.pacificow600),
      ]
  );
}