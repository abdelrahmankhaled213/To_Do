class FavModel{

  final int id;
  final String title;
  final bool isFav;
  final String date;
 final int color1;
 final int color2;

  FavModel( {required this.id
    ,required this.title
    ,required this.isFav
  , required this.color1,
   required this.color2,
    required this.date
    });

factory FavModel.fromJson(Map<String, dynamic> json){
  return FavModel(id: json['id']
      , title: json['title']
      , isFav: json['isFav']==1
      , color1: json['color1']
      , color2: json['color2']
      , date: json['date']
  );
}

Map<String,dynamic> toJson(){
  return {
    'id':id,
    'title':title,
    'isFav':isFav?1:0,
    'color1':color1,
    'color2':color2,
    'date':date
  };

  }
}

