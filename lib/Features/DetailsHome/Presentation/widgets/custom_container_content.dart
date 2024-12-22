import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/model/Task.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';

class CustomContainerContent extends StatelessWidget {

  final Tasks task;

  const CustomContainerContent({ super.key, required this.task });

  @override
  Widget build(BuildContext context) {

final homeDetailsCubit=DetailsHomeCubit.get(context);

return Stack(

      children: [

        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Task Content: ${task.title}",
            style: Styles.LibreCaslonw600.copyWith(fontSize: 18.sp,
                color: Colors.white),),

          Text("Task Date: ${task.date}",style: Styles.LibreCaslonw600.copyWith(fontSize: 18.sp,color: Colors.white),),
        ],
      ),

        Positioned(
            right: 0
            ,top: 2
            ,child: BlocConsumer<DetailsHomeCubit,DetailsHomeState>

              (

              listener: (context, state) async {

                print("State emitted: $state");

                  if (state is UpdateFavouriteTaskSuccess) {
                    showToast(
                    state.isFav
                          ? "Added to favourite"
                          : "Removed from favourite",
                      color: state.isFav
                          ? Colors.green
                          : Colors.red,
                    );


                  }
                  else if (state is UpdateFavouriteTaskFailure) {

                    showToast(state.errorMsg, color: Colors.red);

                  }



              },


               builder: (context, state) {

                 if(state is UpdateFavouriteTaskSuccess){

                   return   IconButton(

                       onPressed: ()async{

                       await  homeDetailsCubit.updateTaskFavourite(
                             task.copyWith(
                               isFav: state.isFav ?0:1,
                             ));


                       },
                       icon: Icon(
                        state.isFav ?
                  Icons.favorite:  Icons.favorite_border
                     ,color: Colors.white,size: 30.sp,)
                   );
                 }


                 return IconButton(

                     onPressed: () async{

                      await homeDetailsCubit.updateTaskFavourite(
                           task.copyWith(
                             isFav: homeDetailsCubit.favourites[task.id]! ?0:1,
                           ));


                     },icon: Icon(

                   task.isFav==0 ?
                   Icons.favorite_border: Icons.favorite
                   ,color: Colors.white,size: 30.sp,)
                 );


               },

            )
        )
   ] );
  }
}
