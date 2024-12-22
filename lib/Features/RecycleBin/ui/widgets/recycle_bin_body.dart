import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/CustomContainer.dart';
import 'package:to_dolist_app/Features/RecycleBin/logic/recycle_bin_cubit.dart';

class RecycleBinBody extends StatelessWidget {

  const RecycleBinBody({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<RecycleBinCubit, RecycleBinState>(

      listener: (context, state) {

        if(state is RestoreSuccess){

          showToast(state.message,color: Colors.green);
        }
        if(state is RestoreFailure){

          showToast(state.message,color: Colors.red);
        }
        if(state is DeleteRecycleSuccess){

          showToast(state.message,color: Colors.red);
        }
      },

      builder: (context, state) {

final recycleBinCubit=RecycleBinCubit.get(context);

        if(state is GetRecycleBinLoading){

          return const Center(
            
              child:  CircularProgressIndicator(
                
                backgroundColor: Colors.black,
                
              )
          );
        }

        if(state is GetRecycleBinLoaded){

          return

state.recycleBinList.isNotEmpty ? Padding(

                padding: EdgeInsets.symmetric(

                  horizontal: 10.w,

                  vertical: 10.h,
                ),

              child: ListView.separated(

                  itemBuilder: (context, index) {

                    return CustomContainer(

                        height: 200.h
                        ,
                        width: double.infinity,
                        color: state.recycleBinList[index].color1,
                        color2: state.recycleBinList[index].color2,

                        child: buildCustomContainerContentRecycle(state, index, recycleBinCubit)
                    );

                  }, separatorBuilder: (context, index) {

                return SizedBox(height: 8.h);

              }, itemCount:state.recycleBinList.length),
            ): buildRecycleBinEmpty();

        }

        return const SizedBox.shrink();
      },
    );
  }

  Row buildCustomContainerContentRecycle(GetRecycleBinLoaded state, int index, RecycleBinCubit recycleBinCubit) {

    return Row(
                          children: [

                            Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                  "Task Content : ${state.recycleBinList[index].title}",
                                  style: Styles.LibreCaslonw600
                                      .copyWith(fontSize: 18.sp,
                                      color: Colors.white ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                                          ),
                                ),

                                                      SizedBox(height: 6.h,),

                                                      Text(
                                                        "Task Date : ${state.recycleBinList[index].date}",
                                                        style: Styles.LibreCaslonw600
                            .copyWith(fontSize: 18.sp,
                            color: Colors.white ),
                                                      ),
                            ],
                            ),


                            Expanded(

                              child: Row(

                                children: [

                                  IconButton(
                                      icon:  Icon(Icons.restore_from_trash
                                        ,color: Colors.white,size: 30.sp,)
                                      ,onPressed: (){

                                                               recycleBinCubit.restoreFromRecycle(

                                  state.recycleBinList[index].copWith(
                                    isRecycle: 0
                                  )
                                                               );
                                  }
                                  ),
                                  IconButton( icon:  Icon(Icons.delete,color: Colors.white,size: 30.sp,)
                                    ,onPressed: (){

                                      recycleBinCubit.deleteFromRecycle(state.recycleBinList[index].id);

                                    }
                                    ,
                                  )
                                ],
                              ),
                            ),


                          ]
                      );
  }
}

Widget buildRecycleBinEmpty(){
  
return Column(

  mainAxisAlignment: MainAxisAlignment.center,

  children: [

     Center(child: Image.asset("assets/image/4021663.png",height: 200.h,)),

     SizedBox(height: 20.h,),

     Text("RecycleBin is Empty",style:Styles.pacificow600),

   ],
);
}