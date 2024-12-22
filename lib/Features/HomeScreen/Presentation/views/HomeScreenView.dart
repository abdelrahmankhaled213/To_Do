import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContainer.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContent.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/custom_alert_Dialog.dart';
import 'package:to_dolist_app/Features/HomeScreen/logic/home_cubit.dart';

import '../widgets/custom_container_content.dart';


class HomeScreenView extends StatelessWidget {

  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {

HomeCubit homeCubit = context.read<HomeCubit>();

    return Scaffold(

        floatingActionButton: FloatingActionButton(

          onPressed: () {

homeCubit.categoryMode = CategoryMode.add;

            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider.value(

                  value: homeCubit,

                  child: const CustomAlertDialog(),
                );
              },
            );
          },

          backgroundColor: Colors.black,

          child: Icon(

            Icons.add,
            size: 16.sp,
            color: Colors.white,

          ),
        ),

        body:

        SafeArea(

    child:  Padding(

      padding: EdgeInsets.symmetric(

        horizontal: 10.w,

      ),

      child: CustomScrollView(

          slivers: [

          SliverToBoxAdapter(

            child: SizedBox(

              height: 20.h,

            ),

          )
          ,

          SliverToBoxAdapter(

            child: Text("To Do List", style: Styles.LibreCaslonw600),

          ),

          SliverToBoxAdapter(

            child: SizedBox(
              height: 20.h,
            ),
          ),

          SliverToBoxAdapter(

              child: Container(

                  padding: EdgeInsets.symmetric(horizontal: 10.w),

                height: 169.h,


                decoration: BoxDecoration(

  borderRadius: BorderRadius.circular(20.r),

  boxShadow: [

    BoxShadow(color: Colors.black12, spreadRadius: 2.r, blurRadius: 4.r)
  ],
),

              child:  const CustomContent(),
            )
          ),

          SliverToBoxAdapter(

            child: SizedBox(
              height: 30.h,
            ),
          ),

           SliverToBoxAdapter(

            child: BlocBuilder<HomeCubit,HomeState>(

              builder: (context, state) {

                if(state is GetHomeCategoriesLoading){

                  return const Center
                    (
                    child: CircularProgressIndicator()
                    ,);
                }
                if(state is GetHomeCategoriesLoaded){

                  return state.categories.isEmpty?

                  buildNoCategories():

                     GridView.builder(

                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics()

                       ,itemCount: state.categories.length

                       ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                       crossAxisCount: 2,

                       crossAxisSpacing: 10.w,

                       mainAxisSpacing: 5.h,
                     ), itemBuilder: (context, index) {

                       return GestureDetector(

                         onLongPress: (){

homeCubit.categoryMode = CategoryMode.update;
homeCubit.idToUpdateCategory = state.categories[index].id;

                           showDialog(
                             context: context,
                             builder: (dialogContext) {
                               return BlocProvider.value(
                                 value:homeCubit,
                                 child: const CustomAlertDialog(),
                               );
                             },
                           );
                         },
                         onTap: (){
                           GoRouter.of(context).
                           push('/DetailsHomeScreen',extra: state.categories[index]);
                         },
                         child: CustomContainer(

                             height:50.h
                             , width: 200.w,
                             color: state.categories[index].color1
                             , color2: state.categories[index].color2

                             , child: CustomContainerContent(

                           category: state.categories[index],

                         )

                         ),
                       );
                     },
                     );

                }
                if(state is GetHomeCategoriesError){

                  return Text(state.error);

                }
                 return const SizedBox.shrink();
              },

            ),
          )
      ]
      ),
    ),
  )
    );
}

  Widget buildNoCategories() {

    return Column(

     children: [

       Image.asset("assets/image/no-content (1).png"),

       Text("No Categories Added ",style:Styles.pacificow600),
           ]
    );
  }

}





showToast(String msg,{Color? color}) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color??Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
);