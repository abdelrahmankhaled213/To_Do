part of 'home_cubit.dart';


sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetHomeCategoriesLoading extends HomeState {

}

final class GetHomeCategoriesLoaded extends HomeState {
  final List<TaskCategory> categories;
  GetHomeCategoriesLoaded(this.categories);
}

final class GetHomeCategoriesError extends HomeState {
  final String error;
  GetHomeCategoriesError(this.error);
}

final class InsertHomeCategoriesLoading extends HomeState {

}
final class InsertHomeCategoriesLoaded extends HomeState {
  final String message;
  InsertHomeCategoriesLoaded(this.message);
}

final class InsertHomeCategoriesError extends HomeState {
  final String message;
  InsertHomeCategoriesError(this.message);
}

final class UpdateHomeCategoriesLoading extends HomeState {

}
final class UpdateHomeCategoriesLoaded extends HomeState {
  final String message;
  UpdateHomeCategoriesLoaded(this.message);
}

final class UpdateHomeCategoriesError extends HomeState {
  final String message;
  UpdateHomeCategoriesError(this.message);
}

final class DeleteHomeCategoriesLoading extends HomeState {

}
final class DeleteHomeCategoriesLoaded extends HomeState {
  final String message;
  DeleteHomeCategoriesLoaded(this.message);
}

final class DeleteHomeCategoriesError extends HomeState {
  final String message;
  DeleteHomeCategoriesError(this.message);
}
