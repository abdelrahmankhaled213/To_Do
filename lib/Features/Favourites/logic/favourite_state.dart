part of 'favourite_cubit.dart';

@immutable

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteLoaded extends FavouriteState {

  final List<FavModel> favourites ;
  FavouriteLoaded({required this.favourites});
}

final class FavouriteError extends FavouriteState {
  final String msg;
  FavouriteError({required this.msg});
}

final class RemoveFavSuccess extends FavouriteState {

  final String msg;


  RemoveFavSuccess({required this.msg});
}

final class RemoveFavFailure extends FavouriteState {

  final String msg;

  RemoveFavFailure({required this.msg});
}
