import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_dolist_app/Core/Injection/service_locator.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/Repo/category_repo.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/views/details_home_screen.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/Favourites/Ui/screens/favourites_screen_view.dart';
import 'package:to_dolist_app/Features/Favourites/logic/favourite_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/HomeScreenRepo/home_screen_repo.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';
import 'package:to_dolist_app/Features/HomeScreen/logic/home_cubit.dart';
import 'package:to_dolist_app/Features/RecycleBin/Data/Repo/recycleBin_repo.dart';
import 'package:to_dolist_app/Features/RecycleBin/logic/recycle_bin_cubit.dart';
import 'package:to_dolist_app/Features/RecycleBin/ui/screens/RecycleScreenView.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/TaskRepo/dateRepo.dart';
import 'package:to_dolist_app/Features/TaskDate/logic/date_cubit.dart';
import 'package:to_dolist_app/Features/TaskDate/presentation/ui/Upcoming.dart';
import 'package:to_dolist_app/Features/TaskDate/presentation/ui/today.dart';
import '../../Features/HomeScreen/Presentation/views/HomeScreenView.dart';

final GoRouter appRouter = GoRouter(

    routes: [

    GoRoute(
      path: '/',
      builder: (context, state) =>  BlocProvider<HomeCubit>(
          create: (context) {
        return HomeCubit(getIt<HomeScreenRepo>())..getCategories();
      },child: const HomeScreenView()),
    ),

    GoRoute(
        path: '/DetailsHomeScreen'
        , builder: (context, state) => BlocProvider(
      create: (context){
        return DetailsHomeCubit(getIt<CategoryRepo>());
      },
          child: DetailsHomeScreen(
              category: state.extra! as TaskCategory,
            ),
        )

    ),

     GoRoute(path: AppRouter.today,builder: (context, state) {

       return BlocProvider(
         create: (context) {
         return DateCubit(getIt<DateRepo>())..getTodayData();
       },
       child:const TodayScreenView(),);
     },),

      GoRoute(

        path: AppRouter.upComing,

        builder: (context, state) {

          var dateChosen = DateTime.now();

          return BlocProvider(

            create: (context) {

              // Create DateCubit and fetch data using the dateChosen

              return DateCubit(getIt<DateRepo>())..getUpComingData(dateChosen);
            },
            child: const UpComingScreenView(),
          );
        },
      ),
      GoRoute(path: AppRouter.recycleBin
,builder: (context, state) {
        return BlocProvider( create: (context) {
          return RecycleBinCubit(getIt<RecycleBinRepo>())..getRecycleBin();
        },child: const RecycleScreenView());
      },
),

GoRoute(path: AppRouter.favorites,builder: (context, state) {

  return BlocProvider(create: (context) {

    return getIt<FavouriteCubit>()..getFavourites();
  },
      child: const FavouritesScreenView());
},

)
    ]

);

class AppRouter{

  static const String home='/';
  static const String detailsHomeScreen='/DetailsHomeScreen';
  static const String upComing='/UpComing';
  static const String today='/Today';
  static const String favorites='/fav';
  static const String recycleBin='/recycleBin';
}