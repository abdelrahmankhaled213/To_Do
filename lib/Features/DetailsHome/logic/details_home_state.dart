part of 'details_home_cubit.dart';

sealed class DetailsHomeState {}

final class DetailsHomeInitial extends DetailsHomeState {}

final class DetailsHomeLoading extends DetailsHomeState {}

final class DetailsHomeLoaded extends DetailsHomeState {

  final List<Tasks> data;

  DetailsHomeLoaded(this.data);

}

final class DetailsHomeError extends DetailsHomeState {

  final String message;

  DetailsHomeError(this.message);
}

final class InsertTaskLoading extends DetailsHomeState {

}

final class InsertTaskLoaded extends DetailsHomeState {
  final String message;
  InsertTaskLoaded(this.message);
}

final class InsertTaskFailed extends DetailsHomeState {
  final String message;
  InsertTaskFailed(this.message);
}


final class UpdateTaskLoading extends DetailsHomeState {

}

final class UpdateTaskLoaded extends DetailsHomeState {

  final String message;

  UpdateTaskLoaded(this.message);

}

final class UpdateTaskFailed extends DetailsHomeState {
  final String message;
  UpdateTaskFailed(this.message);
}
final class UpdateFavouriteTaskSuccess extends DetailsHomeState{

final bool isFav;

UpdateFavouriteTaskSuccess(this.isFav);

}

final class UpdateFavouriteTaskFailure extends DetailsHomeState{

  final String errorMsg;

UpdateFavouriteTaskFailure(this.errorMsg);
}

final class DeleteTaskSuccess extends DetailsHomeState {
  final String message;
  DeleteTaskSuccess (this.message);
}

final class DeleteTaskFailed extends DetailsHomeState {
 final String message;
  DeleteTaskFailed(this.message);
}