import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_dolist_app/Core/Theme/styles.dart';

class CustomTextFormField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
   final IconButton? iconButton;
  final FocusNode? node;
  final String? Function(String? value)? validator;

  const CustomTextFormField({required this.validator,required this.hint,required this.controller, this.iconButton, this.node,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
      child: TextFormField(
        validator: validator,
        focusNode: node,
        cursorColor: Colors.white,
        decoration: InputDecoration(
errorBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.r),
  borderSide: const BorderSide(color: Colors.red),
),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Colors.black),
          ),
          hintText: hint,
          prefixIcon: iconButton,
          hintStyle: Styles.LibreCaslonw600.copyWith(color: Colors.black,fontSize:15.sp ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
