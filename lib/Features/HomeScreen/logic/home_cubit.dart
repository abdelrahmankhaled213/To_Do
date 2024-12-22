import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/HomeScreenRepo/home_screen_repo.dart';
import 'package:to_dolist_app/Features/HomeScreen/Data/model/Category.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  final HomeScreenRepo homeScreenRepo;

static HomeCubit get(context)=>BlocProvider.of(context);


  final TextEditingController categoryNameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Color? color1;

    Color? color2;

    CategoryMode categoryMode = CategoryMode.add;

    int? idToUpdateCategory;
    TaskCategory? taskCategory;


    HomeCubit(this.homeScreenRepo) : super(HomeInitial());

  Future<void> getCategories() async {

    emit(GetHomeCategoriesLoading());
    final Either<String, List<TaskCategory>> result = await homeScreenRepo
        .getHomeCategories();

    result.fold((l) => emit(GetHomeCategoriesError(l))
        , (r) => emit(GetHomeCategoriesLoaded(r)));

  }

  Future<void> insertCategory(TaskCategory category) async {

    emit(GetHomeCategoriesLoading());

    final String result = await homeScreenRepo.insertCategory(category);

    if(result=="inserted Successfully"){

      getCategories();

      emit(InsertHomeCategoriesLoaded(result));
    }

    else{
      emit(InsertHomeCategoriesError(result));
    }
  }

  Future<void> updateCategory(TaskCategory category) async {

    emit(GetHomeCategoriesLoading());

    final String result = await homeScreenRepo.updateCategory(category);

    if(result=="updated Successfully"){

      getCategories();
      emit(UpdateHomeCategoriesLoaded(result));

    }
    else{
      emit(UpdateHomeCategoriesError(result));
    }
  }

  Future<void> deleteCategory(int id) async {
    emit(GetHomeCategoriesLoading());

    final String result = await homeScreenRepo.deleteCategory(id);

    if(result=="deleted Successfully"){
      getCategories();
      emit(DeleteHomeCategoriesLoaded(result));
    }
    else{

      emit(DeleteHomeCategoriesError(result));

    }

  }

@override
  Future<void> close() {
    // TODO: implement close
    categoryNameController.dispose();
    return super.close();

  }
}

enum CategoryMode{add,update}





