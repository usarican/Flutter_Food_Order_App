import 'Yemek.dart';

class TumYemekler {
  List<Yemek> yemekler;
  int success;

  TumYemekler({
    required this.yemekler,
    required this.success
  });

  factory TumYemekler.fromJson(Map<String,dynamic> json){
    var yemekArray = json["yemekler"] as List;
    List<Yemek> yemekler = yemekArray.map((e) => Yemek.fromJson(e)).toList();
    return TumYemekler(yemekler: yemekler, success: json["success"] as int);
  }
}