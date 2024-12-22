import 'package:dartz/dartz.dart';
import 'package:to_dolist_app/Core/DataBaseHelper/databaseservices.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/model/today_task.dart';

class RecycleBinRepo {

  Future<Either<String, List<Today>>> getRecycleBin() async {
    try {
      final data = await DataBaseHelper.getRecycleBinData();
      return Right(data);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }

  Future<Either<String, String>> restoreRecycleBin(Today task) async {
    try {
      final data = await DataBaseHelper.updateRestore(task);
      if (data > 0) {
        return const Right("Restore Successfully");
      }
      return const Right(" Un Restored ");
    }
    catch (e) {
      return left("Something went wrong wrong");
    }
  }

  Future<Either<String, String>> deleteFromRecycleBin(int id) async {

   try{
     final data = await DataBaseHelper.deleteTask(id);
    if (data > 0) {
      return const Right("Deleted Successfully");
    }
    return const Right(" Un Deleted ");
  }
  catch(e){
  return left("Something went wrong wrong");
  }

  }
}