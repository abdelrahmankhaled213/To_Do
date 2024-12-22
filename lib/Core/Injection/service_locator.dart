import 'package:get_it/get_it.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/Repo/category_repo.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/Favourites/Data/Repo/favourite_repo.dart';
import 'package:to_dolist_app/Features/Favourites/logic/favourite_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/HomeScreenRepo/home_screen_repo.dart';
import 'package:to_dolist_app/Features/RecycleBin/Data/Repo/recycleBin_repo.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/TaskRepo/dateRepo.dart';

final GetIt getIt=GetIt.instance;
void setUpServiceLocator() {

  // cubit

  getIt.registerLazySingleton(
        () {
    return DetailsHomeCubit(getIt<CategoryRepo>());
  },
  );

  getIt.registerFactory(() {
    return FavouriteCubit(getIt<FavoriteRepo>());
  },);

  //Repos

  getIt.registerLazySingleton<HomeScreenRepo>((){
    return HomeScreenRepo();
  });

  getIt.registerLazySingleton<CategoryRepo>(() {
    return CategoryRepo();
  },);

  getIt.registerLazySingleton<DateRepo>((){
    return DateRepo();
  });

  getIt.registerLazySingleton<RecycleBinRepo>((){
  return RecycleBinRepo();
  });

  getIt.registerLazySingleton<FavoriteRepo>((){
    return FavoriteRepo();
  });

}