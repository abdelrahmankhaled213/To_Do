import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/Repo/category_repo.dart';
import 'package:to_dolist_app/Features/DetailsHome/Data/model/Task.dart';

part 'details_home_state.dart';

class DetailsHomeCubit extends Cubit<DetailsHomeState> {

  final CategoryRepo categoryRepo;

  final TextEditingController taskText = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  List<String> priorityList = ["low","medium","high"];

  var taskPriority = TaskPriority.low;

  var initialPriority= " Please Select ";

  Map<String,TaskPriority>mapToTaskPriority = {
    "low": TaskPriority.low,
    "medium": TaskPriority.medium,
    "high": TaskPriority.high
  };

  Map<TaskPriority,String>mapToTaskPriority2 = {
    TaskPriority.low: "low",
    TaskPriority.medium: "medium",
    TaskPriority.high: "high"
  };

  Map<int,bool>favourites ={};




  static DetailsHomeCubit get(context) => BlocProvider.of(context);

  DetailsHomeCubit(this.categoryRepo) : super(DetailsHomeInitial());

  getTasks(int id) async{

    if (state is DetailsHomeLoading) {
      log("Skipped getTasks call because it's already loading");
      return; // Prevent redundant loading state
    }

    emit(DetailsHomeLoading());

    if(isClosed){
      return;
    }

    final data =

  await categoryRepo.getDataDependsOnCategoriesAndPriority(
     id:  id,
    priority: mapToTaskPriority2[taskPriority]!
      );

  data.fold((l){

    emit(DetailsHomeError(l));

    },
          (r){

    for(int i=0;i<r.length;i++){
log(r[i].isRecycleBin.toString());
   favourites.addAll({
     r[i].id!: r[i].isFav==1
   }

  );

    }

   emit(DetailsHomeLoaded(r.cast<Tasks>()));});

    }

addTask(Tasks task) async{

final data = await categoryRepo.insertData(
  task
);
data.fold((l){
  emit(InsertTaskFailed(l));}
,(r){

  emit(InsertTaskLoaded(r));});

}

updateTask(Tasks task) async{

final data= await categoryRepo.updateData(
  task
);


data.fold((l){



  emit(UpdateTaskFailed(l));

  }

,(r){

  emit(UpdateTaskLoaded(r));
});

}


  updateTaskFavourite(Tasks task) async {

    // Optimistically toggle the favorite status

    favourites[task.id!] = !favourites[task.id!]!;


    final data = await categoryRepo.updateData(task);

    data.fold(
          (failure) {

        // Revert the favorite status on failure

        favourites[task.id!] = !favourites[task.id!]!;
        emit(UpdateFavouriteTaskFailure(failure));
      },
          (success) async {

        log("Emit once for task ID: ${task.id!}");

          emit(UpdateFavouriteTaskSuccess(favourites[task.id!]!));

        await getTasks(task.categoryId);



      },
    );
  }


deleteTask(Tasks task) async{

    final data= await categoryRepo.deleteData(
      task
    );
    data.fold((l){emit(DeleteTaskFailed(l));
      }
    ,(r){
      emit(DeleteTaskSuccess(r));
    }
    );
}

}

enum TaskPriority{
  low
  ,medium
  ,high
}