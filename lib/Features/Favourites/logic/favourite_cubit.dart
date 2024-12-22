import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_dolist_app/Features/Favourites/Data/Model/favourite.dart';
import 'package:to_dolist_app/Features/Favourites/Data/Repo/favourite_repo.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {

  static FavouriteCubit get(context) => BlocProvider.of<FavouriteCubit>(context);

  final FavoriteRepo favoriteRepo;

  FavouriteCubit(this.favoriteRepo) : super(FavouriteInitial());


  getFavourites()async{
    final data=await favoriteRepo.getFavourites();
    data.fold((l){
      emit(FavouriteError(msg: l));
    } , (value) => emit(FavouriteLoaded(
      favourites: value
    )));
  }

changeFavourites({required int id,required bool isFav})async{

    isFav = !isFav;

    final data=await favoriteRepo.RemoveFav(id: id, isFav: isFav);

    data.fold((l){

      isFav = !isFav;

      emit(RemoveFavFailure(msg: l));

    } , (value) {

      emit(RemoveFavSuccess(msg: value));
      getFavourites();

    }
    );
  }

}


