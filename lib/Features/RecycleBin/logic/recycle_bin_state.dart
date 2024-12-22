part of 'recycle_bin_cubit.dart';

@immutable
sealed class RecycleBinState {}

final class RecycleBinInitial extends RecycleBinState {}

final class GetRecycleBinLoading extends RecycleBinState {

}

final class GetRecycleBinLoaded extends RecycleBinState {

  final List<Today> recycleBinList;

  GetRecycleBinLoaded(this.recycleBinList);
}

final class GetRecycleBinFailure extends RecycleBinState {

  final String errorMsg;

  GetRecycleBinFailure(this.errorMsg);

}

final class RestoreSuccess extends RecycleBinState{

  final String message;

RestoreSuccess(this.message);

}

final class RestoreFailure extends RecycleBinState{
  final String message;
  RestoreFailure(this.message);
}
final class DeleteRecycleSuccess extends RecycleBinState{
  final String message;
DeleteRecycleSuccess(this.message);
}

final class DeleteRecycleFailure extends RecycleBinState{
  final String message;
 DeleteRecycleFailure(this.message);
}