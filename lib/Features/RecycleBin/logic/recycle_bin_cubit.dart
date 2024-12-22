import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_dolist_app/Features/RecycleBin/Data/Repo/recycleBin_repo.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/model/today_task.dart';

part 'recycle_bin_state.dart';

class RecycleBinCubit extends Cubit<RecycleBinState> {

 final RecycleBinRepo recycleBinRepo;

  RecycleBinCubit(this.recycleBinRepo) : super(RecycleBinInitial());

  static RecycleBinCubit get(context)=>BlocProvider.of(context);

getRecycleBin() async {

    final data = await recycleBinRepo.getRecycleBin();
    data.fold(
            (l)=>emit(GetRecycleBinFailure(l))

        , (r){

 emit(GetRecycleBinLoaded(r));

            }
            );
  }

  restoreFromRecycle(Today task)async{

final data= await recycleBinRepo.restoreRecycleBin(task);

data.fold((l){
emit(RestoreFailure(l));
}, (r)async{
  emit(RestoreSuccess(r));
  await getRecycleBin();
});
  }

  deleteFromRecycle(int id) async{

  final data=await recycleBinRepo.  deleteFromRecycleBin(id);
  data.fold((l){
    emit(DeleteRecycleFailure(l));
  }, (r) async {
    emit(DeleteRecycleSuccess(r));
    await getRecycleBin();
  });
  }
}
