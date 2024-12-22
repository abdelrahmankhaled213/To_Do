import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_container_content.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_floating_button.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_pop_menu_button.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/show_Dialog_Box2.dart';
import 'package:to_dolist_app/Features/DetailsHome/logic/details_home_cubit.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContainer.dart';


class DetailsHomeScreen extends StatefulWidget {

  final TaskCategory category;

  const DetailsHomeScreen({ super.key, required this.category});

  @override
  State<DetailsHomeScreen> createState() => _DetailsHomeScreenState();

}

class _DetailsHomeScreenState extends State<DetailsHomeScreen> {

  late DetailsHomeCubit detailsHomeCubit;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    detailsHomeCubit = DetailsHomeCubit.get(context);
    detailsHomeCubit.getTasks(widget.category.id!);
    detailsHomeCubit.taskText.text="";
    detailsHomeCubit.date.text="";
    detailsHomeCubit.time.text="";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: CustomFloatingActionButton(

          detailsHomeCubit: detailsHomeCubit,
          taskCategory: widget.category,

        ),

        body:
        SafeArea(

            child:

            Padding(

              padding: EdgeInsets.symmetric(
                  horizontal: 10.w
                  , vertical: 10.h
              ),

              child: CustomScrollView(

                  slivers: [

                    SliverToBoxAdapter(

                        child: CustomPopMenuButton(
                            taskCategory: widget.category
                            , detailsHomeCubit: detailsHomeCubit
                        )

                    ),


                    SliverToBoxAdapter(
                      child: SizedBox(height: 50.h,),
                    ),

                    SliverToBoxAdapter(
                      child:
                    BlocBuilder<DetailsHomeCubit ,DetailsHomeState>(

                      builder: (context, state) {

                        if(state is DetailsHomeLoaded) {

                          if(state.data.isEmpty){
                            return  buildNoTasksAdded();
                          }

                          return

                            ListView.separated(

                              physics: const NeverScrollableScrollPhysics(),

                              shrinkWrap: true,

                              separatorBuilder: (context, index) {

                                return SizedBox(height: 10.h,);

                                },

                              itemCount: state.data.length,

                              itemBuilder: (context, index) {

                                return

                                  GestureDetector(

                                      onLongPress: () async {

                                        await showDialogBox2(
                                            category: widget.category,
                                            context, task: state.data[index]
                                        );

                                        Navigator.pop(context);

                                      },

                                      child: GestureDetector(

                                        onLongPress: () {

                                          showDialogBox2(
                                              context, task: state.data[index]
                                              , category: widget.category);
                                        },

                                        child: CustomContainer(

                                            color: widget.category.color1,
                                            color2: widget.category.color2,
                                            width: double.infinity,
                                            height: 200.h,

                                            child: CustomContainerContent(

                                              task: state.data[index],

                                            )
                                        ),
                                      )

                                  );

                                },

                            );

                        }


                        if(state is DetailsHomeError){

                          return Center(
                            child: Text(state.message
                            ),
                          );

                        }


                        return Center(

                          child: CircularProgressIndicator(

                            color: Color(widget.category.color1),
                            backgroundColor: Color(widget.category.color2),

                          ),
                        );
                      },
                    ),
                    )
                  ]
              ),
            )
        )

    );
  }

}


Theme customThemeTimePicker(Widget? child) {
  return Theme(

    data: ThemeData(
    ).copyWith(
        colorScheme: const ColorScheme.dark(
            primary: Colors.white
        )
    ),
    child: child!,
  );
}


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}


validate(String? value, {String? msg}) {
  if (value!.isEmpty) {
    return msg;
  }
  return null;
}

Widget buildNoTasksAdded() {

  return Column(

      children: [

        Image.asset(
          "assets/image/no-content (1).png",
        ),

        Text("No Tasks Added ",style:Styles.pacificow600),

      ]
  );
}