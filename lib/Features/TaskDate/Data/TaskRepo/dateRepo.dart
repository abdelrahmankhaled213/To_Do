import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:to_dolist_app/Core/DataBaseHelper/databaseservices.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/model/today_task.dart';

class DateRepo{

  Future<Either<String,List<Today>>>getTodayData(DateTime time)async{

    return await _getData(() => DataBaseHelper.getAllDataToday(time));

  }

  Future<Either<String,List<Today>>>getUpComingData(DateTime time)async{

return  await _getData(() => DataBaseHelper.getAllDataUpcoming(time));

  }


  Future<Either<String,String>>updateFav({required int id,required int isFav})async{
    try {

      await DataBaseHelper.updateFav(isFav: isFav, id: id);

      if(isFav==1){
log("added to fav");
  return const Right("Added To Favourites");

} else{
log("removed from fav");

  return const Right("Removed From Favourites");

      }

    } catch(e){

      log(e.toString());

      return const Left("there is something went wrong");
    }
  }

}



Future<Either<String,List<Today>>>_getData<T>(  Future<T> Function() getOurData)
async{

  try {
    final data = await getOurData();
    return Right(data as List<Today>);
  }catch(e){
    log(e.toString());
    return const Left("there is something went wrong");
  }


}





