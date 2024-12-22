import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Features/DetailsHome/Presentation/widgets/custom_text_form.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/custom_elevated_button.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/custom_list_view.dart';
import 'package:to_dolist_app/Features/HomeScreen/logic/home_cubit.dart';

class CategoryFormField extends StatefulWidget {

  const CategoryFormField({super.key});

  @override
  State<CategoryFormField> createState() => _CategoryFormFieldState();
}

class _CategoryFormFieldState extends State<CategoryFormField> {

  late HomeCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cubit = HomeCubit.get(context);

  cubit.color1 = colorsList[0];
  cubit.color2 = colorsList[0];

  }



  List<Color>colorsList= const [
    Colors.deepPurple,
    Colors.green,
    Colors.indigo,
    Colors.pink,
    Colors.orange
  ];

  int ?currentIndexList1;
  int ?currentIndexList2;

  @override
  Widget build(BuildContext context) {



    return  SingleChildScrollView(

      child: Form(
        key: cubit.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h
          ),
          child: Column(


            children: [

              CustomTextFormField(
                validator: (value) {
                  if(value!.isEmpty){

                    return "Category name must not be empty";
                  }
                  return null;
                },
                  hint: "Category name"
                  , controller: cubit.categoryNameController),

              SizedBox(
                height: 8.h,
              ),

              CustomListViewBuilder(
                currentIndex: currentIndexList1??0,
                colorsList: colorsList,
                onTap: (index) {

                  setState(() {
                    currentIndexList1 = index;
                  });

                  cubit.color1 = colorsList[index];

                },

              ),

              SizedBox(
                height: 8.h,
              ),

              CustomListViewBuilder(
                currentIndex: currentIndexList2??0,
                colorsList: colorsList,
                onTap:(index) {

                  setState(() {
                    currentIndexList2 = index;
                  });

                  cubit.color2 = colorsList[index];
                },
              ),
              SizedBox(
                height: 8.h,
              ),
             const  CustomElevatedButton()

            ],
          ),
        ),
      ),
    );
  }

}
