import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/views/HomeScreenView.dart';
import 'package:to_dolist_app/Features/HomeScreen/logic/home_cubit.dart';


class CustomElevatedButton extends StatelessWidget {


  const CustomElevatedButton({super.key});


  @override
  Widget build(BuildContext context) {

    final cubit = context.read<HomeCubit>();

    return BlocConsumer< HomeCubit, HomeState>(

      listener: (context, state) {

        if(state is GetHomeCategoriesError){
          showToast(state.error);
        }
        if(state is GetHomeCategoriesLoaded){
          showToast(
              cubit.categoryMode == CategoryMode.add

              ?"Added Successfully":"Updated Successfully");
        }
      },

      builder: (context, state) {

        if(state is GetHomeCategoriesLoading){

          return const Center
            (
            child: CircularProgressIndicator(

            color: Colors.blueGrey,

          )
            ,
          );
        }
        return ElevatedButton(

            onPressed: ()
            {

if(cubit.formKey.currentState!.validate()){
   addOrUpdateFun(cubit, context);
}

            }

            ,style: ElevatedButton

            .styleFrom(

          fixedSize: Size(130.w, 50.h)

          ,backgroundColor: Colors.blueGrey,

          elevation: 10,

          padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 20.w),


        ),
            child:  Text(cubit.categoryMode == CategoryMode.add? "Add"
                :"Update",style: Styles.LibreCaslonw600.copyWith(
                color: Colors.white
            )
            )

        );
      },
    );
  }


  Future<void> addOrUpdateFun(HomeCubit cubit, BuildContext context) async {

    cubit.taskCategory=TaskCategory(color2: cubit.color2!.value
        , color1: cubit.color1!.value, name: cubit.categoryNameController.text);

        if(CategoryMode.add == cubit.categoryMode){
          await cubit.insertCategory(
              cubit.taskCategory!);

    Navigator.pop(context);

        }

        else if(CategoryMode.update == cubit.categoryMode){

        final task=  cubit.taskCategory!.copyWith(

              name: cubit.categoryNameController.text,
              color1: cubit.color1!.value,
              color2: cubit.color2!.value,
              id: cubit.idToUpdateCategory
          );

          await cubit.updateCategory(
            task
            );

          Navigator.pop(context);
        }
  }

}

