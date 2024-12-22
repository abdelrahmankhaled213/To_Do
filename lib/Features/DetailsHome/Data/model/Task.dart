class Tasks{
   int? id;
 final  String title;
 final  String date;
  int? isFav;
  String? time;
 final int categoryId;
 final String priority;
 int? isRecycleBin;

 Tasks({
   this.time,
   required this.priority,
 required this.title,
 required this.date,
  this.isFav,
   this.id,
 required this.categoryId,
   this.isRecycleBin

});

Tasks copyWith({
int ? id,
int? isFav,
int? categoryId,
String? title,
String? date,
String? priority,
int ? isRecycleBin,
}){
  return Tasks(
    priority: priority??this.priority,
    categoryId: categoryId ?? this.categoryId,
    id: id ?? this.id,
    title: title ?? this.title,
    date: date ?? this.date,
    isFav:  isFav ?? this.isFav,
    isRecycleBin: isRecycleBin??this.isRecycleBin
  );

}


  factory Tasks.fromJson(Map<String, dynamic> json) {

    return Tasks(
      priority: json['priority'],
      isFav: json['isFav']??0,
      categoryId: json['categoryId'],
      id: json['id'],
      title: json['title'],
      date: json['date'],
      isRecycleBin: json['recycle']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title': title,
        'date': date,
      'categoryId':categoryId,
      "isFav":isFav,
      "priority":priority,
      "recycle":isRecycleBin
    };
  }


 @override
 bool operator == (Object other) {
   return other is Tasks && other.priority == priority &&
        other.time == time && other.title == title && other.date == date &&other.priority==priority;
 }

 @override
 int get hashCode => id.hashCode;

}