import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/TaskRepo/dateRepo.dart';
import 'package:to_dolist_app/Features/TaskDate/Data/model/today_task.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {

  final DateRepo dateRepo;

  static DateCubit get(context) => BlocProvider.of<DateCubit>(context);

  final Map<int,bool>_favouritesToday = {};

  final Map<int,bool>_favouritesUpcoming = {};

    DateTime _date= DateTime.now();

  Map<int,bool>get favouritesToday => Map.unmodifiable(_favouritesToday);
  Map<int,bool>get favouritesUpcoming => Map.unmodifiable(_favouritesUpcoming);

  setTime(DateTime date){

  _date=date;
}

 DateTime get date{

   return _date;
 }


  DateCubit(this.dateRepo) : super(DateInitial());

  getTodayData(){

    var dateNow = DateTime.now();
   dateRepo.getTodayData(dateNow).
   then((value) {
     value.fold(
             (error){

       emit(GetTodayError(error)
       );
     }, (myData){

               for (int i = 0; i < myData.length; i++) {

                 _favouritesToday.addAll({
myData[i].id : myData[i].isFav==1
                 });
               }

       emit(GetTodayLoaded(myData));
     });

   },);
  }

  getUpComingData(DateTime time)async{

    final data= await dateRepo.getUpComingData(time);

    data.fold((l) {
  emit(GetDataUpcomingError(l));
    }, (r) {

      for (int i = 0; i < r.length; i++) {

        _favouritesUpcoming.addAll({
          r[i].id : r[i].isFav==1
        });

      }

      emit(GetDataUpcomingLoaded(r));

      },
    );


  }

  changeFavToday({required int id,required int isFav} ) async{

    _favouritesToday[id] = !_favouritesToday[id]!;

   final data= await dateRepo.updateFav(
     isFav: isFav,
     id: id
   );


    data.fold(

            (l){

      _favouritesToday[id] = !_favouritesToday[id]!;

      emit(UpdateFavErrorToday(l));
    },

            (r)async{

emit(UpdateFavSuccessToday(r));

await getTodayData();

            }
    );

  }

  changeFavUpComing({required int id,required int isFav}) async{

    _favouritesUpcoming[id] = !_favouritesUpcoming[id]!;

    final data= await dateRepo.updateFav(
      isFav: isFav,
      id: id
    );

    data.fold(

            (l) {

          _favouritesUpcoming[id] = !_favouritesUpcoming[id]!;

          emit(UpdateFavErrorUpComing(l));

          },
    (r) async {

emit(UpdateFavSuccessUpComing(r));

await getUpComingData(date);

    }

    );
  }

}
