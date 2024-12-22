class Today {
  final int id;
  final int color1;
  final int color2;
  final int isFav;
  final String title;
  final String date;
  int? isRecycle;

  Today({
    required this.id,
    required this.color1,
    required this.color2,
    required this.isFav,
    required this.title,
    this.isRecycle,
    required this.date,
  });

  factory Today.fromJson(Map<String, dynamic> json) {
    return Today(
        id: json['id'],
        color1: json['color1'],
        color2: json['color2'],
        isFav: json['isFav'] ?? false,
        title: json['title'] ?? "",
      date: json['date'] ?? "",
      isRecycle: json['recycle'],
    );
  }

  toJson() {
    return {
      'id': id,
      'color1': color1,
      'color2': color2,
      'isFav': isFav,
      'title': title,
      'recycle':isRecycle
    };
  }

  Today copWith(
      {int? id, int? color1, int? color2, int? isFav, String? title,int? isRecycle,String? date}) {
    return Today(
        id: id ?? this.id,
        color1: color1 ?? this.color1,
        color2: color2 ?? this.color2,
        isFav: isFav ?? this.isFav,
        title: title ?? this.title,
      isRecycle: isRecycle?? this.isRecycle,
      date: date??this.date
    );
  }
}
