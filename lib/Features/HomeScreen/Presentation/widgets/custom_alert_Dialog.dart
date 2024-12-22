import 'package:flutter/material.dart';
import 'package:to_dolist_app/Features/HomeScreen/Presentation/widgets/category_from_field.dart';

class CustomAlertDialog extends StatelessWidget {

  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
       return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: ConstrainedBox(
        constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
    maxHeight: MediaQuery.of(context).size.height * 0.6,
    ),
          child: const CategoryFormField(),
    ),

    );
  }
}