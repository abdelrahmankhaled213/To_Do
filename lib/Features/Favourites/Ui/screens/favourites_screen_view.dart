import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/Favourites/Ui/widgets/changeFav.dart';
import 'package:to_dolist_app/Features/Favourites/logic/favourite_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContainer.dart';

class FavouritesScreenView extends StatelessWidget {
  const FavouritesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(

        child: Scaffold(

          body: FavouritesBody(),
        )
    );
  }
}

class FavouritesBody extends StatelessWidget {

  const FavouritesBody({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FavouriteCubit,FavouriteState>(

      builder: (context, state) {

        if(state is FavouriteLoading){

          return const Center(

            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),

          );
        }

        if(state is FavouriteLoaded){

          return Padding(

            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),

            child:  state.favourites.isEmpty ?  buildNoFavourites() : ListView.builder(

              itemBuilder: (context, index) {

                return Stack(

                    children: [

                      CustomContainer(height: 200.h
                          ,
                          width: double.infinity,
                          color: state.favourites[index].color1,
                          color2: state.favourites[index].color2,
                          child:Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text("Task Content : ${state.favourites[index].title}",

                                      style: Styles.LibreCaslonw600.copyWith(fontSize: 18.sp,
                                          color: Colors.white),),
SizedBox(height: 5.h,),
                                    Text("Task Date : ${state.favourites[index].date}",

                                      style: Styles.LibreCaslonw600.copyWith(fontSize: 18.sp,
                                          color: Colors.white),),
                                  ],
                                ),

                              ]
                          ),
                          ),


                       Positioned(
                          top: 2,
                          right: 0,
                        child:ChangeFav(
                          fav: state.favourites[index],
                        ) ,
                      )
                    ]
                );
              },

              itemCount: state.favourites.length,
            ),
          );
        }

        if(state is FavouriteError){

          return  Center(
            child: Text(state.msg),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  buildNoFavourites() {

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        Center(child: Image.asset("assets/image/10218522.png",height: 200.h,)),

        SizedBox(height: 6.h,),

        Text("No Favourites Added",style: Styles.pacificow600.copyWith(fontSize: 18.sp,
            ),),
      ],
    );
  }
}

