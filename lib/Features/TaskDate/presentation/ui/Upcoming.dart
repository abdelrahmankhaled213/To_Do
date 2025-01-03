import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContainer.dart';
import 'package:to_dolist_app/Features/TaskDate/logic/date_cubit.dart';
import 'package:to_dolist_app/Features/TaskDate/presentation/ui/today.dart';
import 'package:to_dolist_app/Features/TaskDate/presentation/widgets/isFav_upcoming.dart';


class UpComingScreenView extends StatelessWidget {

  const UpComingScreenView({super.key});

  @override

  Widget build(BuildContext context) {
    return
      Scaffold(

          body: BlocBuilder<DateCubit,DateState>(

            builder:
                (context, state) {

              final dateTimeNow=DateTime.now();
              final dateCubit = DateCubit.get(context);

              if(state is GetDataUpcomingLoading){
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }

              if (state is GetDataUpcomingLoaded) {

                  return SafeArea(
                    child: SingleChildScrollView( // Wrap everything inside SingleChildScrollView for a single scrolling behavior
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w
                        ),
                        child: Column( // Column to arrange the widgets vertically
                          children: [
                            EasyDateTimeLine(
                              initialDate: dateCubit.date,
                              activeColor: Colors.black,
                              onDateChange: (date) async {
                                dateCubit.setTime(date);
                                await dateCubit.getUpComingData(date);
                              },
                            ),
                            SizedBox(height: 15.h),

                            // The list of upcoming tasks, now inside the scrollable column
                            state.upComingData.isEmpty
                                ? buildNoTaskInThatDay()
                                : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(), // Disable scroll within the list
                              separatorBuilder: (context, index) => SizedBox(height: 5.h),
                              itemCount: state.upComingData.length,
                              shrinkWrap: true, // Important: this allows the ListView to fit within the scrollable area
                              itemBuilder: (context, i) {
                                return Stack(
                                  children: [
                                    CustomContainer(
                                      height: 200.h,
                                      width: double.infinity,
                                      color: state.upComingData[i].color1,
                                      color2: state.upComingData[i].color2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 290.w,
                                                child: Text(
                                                  "Task Content: ${state.upComingData[i].title}",
                                                  style: Styles.LibreCaslonw600.copyWith(
                                                      fontSize: 18.sp, color: Colors.white),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 0,
                                      child: IsFavouriteUpComing(
                                        dateCubit: dateCubit,
                                        today: state.upComingData[i],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }


              return const SizedBox();

              },

          )
      );
    }
}