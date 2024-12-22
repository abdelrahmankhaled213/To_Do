import 'package:flutter/material.dart';
import 'package:to_dolist_app/Features/RecycleBin/ui/widgets/recycle_bin_body.dart';

class RecycleScreenView extends StatelessWidget {

  const RecycleScreenView({super.key});

  @override
  Widget build(BuildContext context) {

    return const SafeArea(

      child: Scaffold(

        body: RecycleBinBody(),
      ),
    );
  }
}

