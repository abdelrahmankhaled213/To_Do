import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:to_dolist_app/Core/DataBaseHelper/databaseservices.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/model/Task.dart';

class CategoryRepo{

  Future<Either<String, List<Tasks>>> getDataDependsOnCategoriesAndPriority({
    required
  final int id ,
    required
    final String priority ,

  })

  async {
    try {

     final  data = await DataBaseHelper.getDataDependsOnCategoryAndPriority(
        id: id,priority: priority);

     return right(data);

    }

    catch (e) {
      log(e.toString());
    return left("Something went wrong in the Database");
  }

  }

Future<Either<String, String>> insertData(Tasks task)async{  

 final id=await DataBaseHelper.insertTask(task);

return await insertOrUpdateDataOrDelete(id,type: "Insert");


}
Future<Either<String, String>> updateData(Tasks task)async{

final id=await  DataBaseHelper.updateTask(task);

return await insertOrUpdateDataOrDelete(id,type: "Update");
  
}

Future<Either<String, String>> deleteData(Tasks task)async{

  final taskId=await  DataBaseHelper.updateTask(task);
  
return await insertOrUpdateDataOrDelete(taskId,type: "Delete");
  
}

}

Future< Either <String, String >> insertOrUpdateDataOrDelete(int id,{required final String type})async{
  try{
  if(id>0){
    log("$type Successfully");
    return  Right("$type Successfully");
  }else{
    log("$type failed");
    return  Right("$type failed");
  }
  }catch(e){
    log(e.toString());
    return const Left("Something went wrong in the Database");
  }
}