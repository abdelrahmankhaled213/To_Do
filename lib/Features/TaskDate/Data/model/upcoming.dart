class UpComing{

  final int id;
  final int color1;
  final int color2;
  final int isFav;
  final String title;

  UpComing({
    required this.id,
    required this.color1,
    required this.color2,
    required this.isFav,
    required this.title
  });

 factory UpComing.fromJson(Map<String, dynamic> json){
   return UpComing(
       id: json['id'],
       color1: json['color1'],
       color2: json['color2'],
       isFav: json['isFav'] ?? false,
       title: json['title']
   );
 }
}