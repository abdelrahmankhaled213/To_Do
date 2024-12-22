import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/Favourites/Data/Model/favourite.dart';
import 'package:to_dolist_app/Features/Favourites/logic/favourite_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';

class ChangeFav extends StatelessWidget {

  final FavModel fav;

  const ChangeFav({super.key,required this.fav});


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<FavouriteCubit,FavouriteState>(

        builder: (context, state) {

  final cubit = FavouriteCubit.get(context);

  return IconButton(

    onPressed: () async  =>

     await cubit.changeFavourites(id: fav.id, isFav: fav.isFav),

    icon: Icon(
      fav.isFav ? Icons.favorite : Icons.favorite_border , color: Colors.white, size: 30.sp,),
);

    }

    , listener: (context, state) {

      if(state is RemoveFavSuccess){

        showToast(state.msg,color: Colors.red);

      }

      if(state is RemoveFavFailure){

        showToast(state.msg,color: Colors.red);

      }

    },
    ) ;
  }
}
