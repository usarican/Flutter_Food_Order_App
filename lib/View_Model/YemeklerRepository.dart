import 'dart:convert';
import 'package:bootcamp_final_project/Constants/YemeklerConstants.dart';
import 'package:bootcamp_final_project/Model/SepetYemek.dart';
import 'package:bootcamp_final_project/Model/SepettekiYemekler.dart';
import '../Model/Yemek.dart';
import '../Model/TumYemekler.dart';
import 'package:http/http.dart' as http;

class YemeklerRepository {

  List<Yemek> parseYemekCevap(String respond){
    return TumYemekler.fromJson(json.decode(respond)).yemekler;
  }

  List<SepetYemek> parseSepettekiYemeklerCevap(String respond){
    if(respond.isNotEmpty){
      return SepettekiYemekler.fromJson(json.decode(respond)).sepettekiYemekler;
    }
    else{
      return <SepetYemek>[];
    }

  }

  Future<List<Yemek>> tumYemekleriGetir() async {
    var url = Uri.parse(YemeklerConstants.TUM_YEMEKLER_API_URL);
    var respond = await http.get(url);
    return parseYemekCevap(respond.body);
  }

  Future<List<SepetYemek>> sepettekiYemekleriGetir(String kullanici_adi) async {
    var url = Uri.parse(YemeklerConstants.SEPETTEKI_YEMEKLER_API_URL);
    var data = {"kullanici_adi": kullanici_adi.toString()};
    var respond = await http.post(url,body:data);
    if(respond.body.isNotEmpty && respond.body.length != 5){
      return parseSepettekiYemeklerCevap(respond.body);
    }
    else{
      return <SepetYemek>[];
    }
  }

  Future<void> sepeteYemekEkleme(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async {
    var url = Uri.parse(YemeklerConstants.SEPETE_YEMEK_EKLEME_API_URL);
    var data = {
      "yemek_adi":yemek_adi.toString(),
      "yemek_resim_adi":yemek_resim_adi.toString(),
      "yemek_fiyat" : yemek_fiyat.toString(),
      "yemek_siparis_adet":yemek_siparis_adet.toString(),
      "kullanici_adi":kullanici_adi.toString()
    };
    await http.post(url,body:data);
  }

  Future<void> sepettenYemekSil(String sepet_yemek_id,String kullanici_adi) async{
    var url = Uri.parse(YemeklerConstants.SEPETTEN_YEMEK_SILME_API_URL);
    var data = {"sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi.toString()};
    await http.post(url,body: data);
  }


}