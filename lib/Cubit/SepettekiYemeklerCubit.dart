import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/SepetYemek.dart';
import '../View_Model/YemeklerRepository.dart';

class SepetCubit extends Cubit<List<SepetYemek>> {
  SepetCubit() : super(<SepetYemek>[]);

  var yemeklerRepo = YemeklerRepository();

  Future<void> sepettekiYemekleriGetir(String kullanici_adi) async {
    var list = await yemeklerRepo.sepettekiYemekleriGetir(kullanici_adi);
      emit(list);

  }

  Future<void> sepettenYemekSilme(String sepet_yemek_id,String kullanici_adi) async{
    await yemeklerRepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepettekiYemekleriGetir(kullanici_adi);
  }

  Future<void> sepeteYemekEkleme(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async {
    await yemeklerRepo.sepeteYemekEkleme(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
  Future<double> toplamFiyat(String kullanici_adi) async {
    double toplam = 0.0;
    var list = await yemeklerRepo.sepettekiYemekleriGetir(kullanici_adi);
    for(int i=0;i<list.length;i++){
      SepetYemek sepettekiYemek = list[i];
      toplam += double.parse(sepettekiYemek.yemek_fiyat);
    }
    print(toplam);
    return toplam;
  }
}