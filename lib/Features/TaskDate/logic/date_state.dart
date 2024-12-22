part of 'date_cubit.dart';


sealed class DateState {}
final class DateInitial extends DateState {}
final class GetTodayLoading extends DateState{

}
final class GetTodayLoaded extends DateState{


  final List<Today>taskList;

GetTodayLoaded(this.taskList);

}
final class GetTodayError extends DateState{

  final String errorMsg;

GetTodayError(this.errorMsg);

}
final class GetDataUpcomingLoading extends DateState{

}
final class GetDataUpcomingLoaded extends DateState{

  final List<Today>upComingData;

  GetDataUpcomingLoaded(this.upComingData);

}

final class GetDataUpcomingError extends DateState
{
  final String errorMsg;

  GetDataUpcomingError(this.errorMsg);

}

final class UpdateFavErrorToday extends DateState {

  final String errorMsg;

  UpdateFavErrorToday(this.errorMsg);
}

final class UpdateFavSuccessToday extends DateState {

  final String message;

  UpdateFavSuccessToday(this.message);

}

final class UpdateFavErrorUpComing extends DateState {

  final String errorMsg;

  UpdateFavErrorUpComing(this.errorMsg);
}

final class UpdateFavSuccessUpComing extends DateState {

  final String message;

  UpdateFavSuccessUpComing(this.message);

}
