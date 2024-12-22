import 'package:dartz/dartz.dart';

import 'package:to_dolist_app/Core/DataBaseHelper/databaseservices.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';

class HomeScreenRepo {
  Future<Either<String, List<TaskCategory>>> getHomeCategories() async {
    try {
      final myDb = await DataBaseHelper.getCategories();
      return Right(myDb);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }

  Future<String>insertCategory(TaskCategory category) async {
 try{
   final  String message=await DataBaseHelper.insertCategory(category);
   return message;
 }catch(e){
   return "Something went wrong";
 }
  }

  Future<String> updateCategory(TaskCategory category) async {
    try{
      final  String message=await DataBaseHelper.updateCategory(category);
      return message;
    }catch(e){
      return "Something went wrong";
    }
  }

Future<String> deleteCategory(int id)async{
  try{
    final  String message=await DataBaseHelper.deleteCategory(id);
    return message;
  }catch(e){
    return "Something went wrong";
  }
}
}