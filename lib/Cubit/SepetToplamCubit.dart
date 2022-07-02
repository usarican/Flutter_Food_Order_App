import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/SepetYemek.dart';
import '../View_Model/YemeklerRepository.dart';

class ToplamCubit extends Cubit<double> {
  ToplamCubit() : super(0.0);


  var yemeklerRepo = YemeklerRepository();

  Future<void> toplamFiyat(String kullanici_adi) async {
    double toplam = 0.0;
    var list = await yemeklerRepo.sepettekiYemekleriGetir(kullanici_adi);
    for(int i=0;i<list.length;i++){
      SepetYemek sepettekiYemek = list[i];
      toplam += double.parse(sepettekiYemek.yemek_fiyat);
    }
    emit(toplam);
  }
}