import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:to_dolist_app/Core/routes/app_router.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/task_features.dart';


class CustomContent extends StatelessWidget {

  const CustomContent({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(

      children: [

        GestureDetector(
                    onTap: () =>

        navigatePush(context, path: AppRouter.upComing)

                    ,child: const TaskFeatures(icon: Icons.sunny,featureName: "UpComing",)),

                    Divider(thickness: 2.h,color: Colors.white,),

        GestureDetector(onTap:  () =>

          navigatePush(context, path: AppRouter.today),

        child: const TaskFeatures(icon: Icons.calendar_month ,featureName: "Today",)),

                    Divider(thickness: 2.h,color: Colors.white,),

                    GestureDetector(
        onTap: () =>
          navigatePush(context, path: AppRouter.favorites)
        ,
        child: const TaskFeatures(  icon: Icons.favorite_border
          ,featureName: "Favourites",),
                    ),

                    Divider(thickness: 2.h,color: Colors.white,),

                    GestureDetector(
        onTap: () =>
            navigatePush(context, path: AppRouter.recycleBin)
        ,
        child: const TaskFeatures(  icon: Icons.delete
          ,featureName: "Recycle Bin",),
                    )
      ],
    );
  }
}

void navigatePush(context,{required String path}) => GoRouter.of(context).push(path);