import 'SepetYemek.dart';

class SepettekiYemekler {
  List<SepetYemek> sepettekiYemekler;
  int success;

  SepettekiYemekler({
    required this.sepettekiYemekler,
    required this.success
    });

  factory SepettekiYemekler.fromJson(Map<String,dynamic> json){
    var sepetYemeklerArray = json["sepet_yemekler"] as List;
    List<SepetYemek> sepettekiYemekler = sepetYemeklerArray.map((e) => SepetYemek.fromJson(e)).toList();
    return SepettekiYemekler(sepettekiYemekler: sepettekiYemekler, success: json["success"] as int);

  }
}