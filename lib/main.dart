import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Injection/service_locator.dart';
import 'package:to_dolist_app/Core/routes/app_router.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  setUpServiceLocator();

  setPreferredOrientations();

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(

      designSize: const Size(360, 690),


      minTextAdapt: true,

      splitScreenMode: true,

      child: MaterialApp.router(



        theme: ThemeData(

          primarySwatch: Colors.grey,

        ),

        routerConfig: appRouter,


        debugShowCheckedModeBanner: false,

      ),

    );

  }

}

void setPreferredOrientations() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyBlocObserver extends BlocObserver {

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

