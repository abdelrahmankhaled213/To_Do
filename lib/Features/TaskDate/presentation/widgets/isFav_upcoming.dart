import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/model/today_task.dart';
import 'package:to_dolist_app/Features/TaskDate/logic/date_cubit.dart';

class IsFavouriteUpComing extends StatelessWidget {

  final Today today;

  final DateCubit dateCubit;

  const IsFavouriteUpComing({super.key,required this.dateCubit,required this.today});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DateCubit,DateState>(


      builder: (context, state) {

        if (state is UpdateFavSuccessUpComing) {

          return IconButton(

              onPressed: () async {

               await dateCubit.changeFavUpComing(
                 isFav: dateCubit.favouritesUpcoming[today.id]! ? 0 : 1,
                 id: today.id
                );

              },

              icon: Icon(
                dateCubit.favouritesUpcoming[today.id]!

                    ?   Icons.favorite_border:Icons.favorite,
                color: Colors.white, size: 30.sp,)
          );

        }

        return

          IconButton(

              onPressed: () async{

                await dateCubit.changeFavUpComing(
                    isFav: dateCubit.favouritesUpcoming[today.id]! ? 0 : 1,
                    id: today.id
                );



              },
              icon: Icon( dateCubit.favouritesUpcoming[today.id]!
                  ? Icons.favorite : Icons.favorite_border ,
                color: Colors.white, size: 30.sp,)
          );

      },

      listener:(context, state) {

        if(state is UpdateFavSuccessUpComing) {

          if (state.message == "Added To Favourites") {

            showToast(state.message);

          }

          else if (state.message == "Removed From Favourites") {

            showToast(state.message, color: Colors.red);

          }
        }
      },
    );
  }
}
