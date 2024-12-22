import 'package:dartz/dartz.dart';
import 'package:to_dolist_app/Core/DataBaseHelper/databaseservices.dart';
import 'package:to_dolist_app/Features/Favourites/Data/Model/favourite.dart';

class FavoriteRepo {

Future<Either<String,List<FavModel>>> getFavourites() async {
    try {

      final data = await DataBaseHelper.getFavourites();
      return Right(data);

    }
    catch(e){

      return Left(e.toString());

    }

  }

  Future<Either<String,String>> RemoveFav( {required int id,required bool isFav}) async {

    try {
      final data=await DataBaseHelper.updateFav(isFav: isFav, id: id);

      return const Right("Removed From Favourites");

    }catch(e){
      return const Left("SomeThing went wrong");
    }
   
 } 
}