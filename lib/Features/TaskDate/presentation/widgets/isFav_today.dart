import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/model/today_task.dart';
import 'package:to_dolist_app/Features/TaskDate/logic/date_cubit.dart';

class IsFavorite extends StatelessWidget {

  final Today today;

  final DateCubit dateCubit;

  const IsFavorite({super.key,required this.today,required this.dateCubit});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DateCubit,DateState>(

      listener: (context, state) {

        if(state is UpdateFavSuccessToday) {

          if(state.message == "Added To Favourites"){

            showToast(state.message);

          }

          else if(state.message == "Removed From Favourites"){

            showToast(state.message,color: Colors.red);

          }

        }
      },
      builder: (context, state) {

        if (state is UpdateFavSuccessToday) {

          return IconButton(

              onPressed: () async{
                await dateCubit.changeFavToday(
              id: today.id,
                      isFav: dateCubit.favouritesToday[today.id]! ? 0 : 1

                );

              },

              icon: Icon(

                dateCubit.favouritesToday[today.id]!

                    ?   Icons.favorite_border:Icons.favorite,
                color: Colors.white, size: 30.sp,)
          );

        }

        return

          IconButton(

              onPressed: () async {
              await  dateCubit.changeFavToday(
                  id: today.id,
                  isFav: dateCubit.favouritesToday[today.id]! ? 0 : 1
                );

              },

              icon: Icon( dateCubit.favouritesToday[today.id]!
                  ? Icons.favorite : Icons.favorite_border ,
                color: Colors.white, size: 30.sp,)
          );

      },
    );
  }
}