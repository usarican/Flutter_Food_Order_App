import 'package:flutter_bloc/flutter_bloc.dart';

import '../View_Model/YemeklerRepository.dart';

class UrunSayisiCubit extends Cubit<int>{
  UrunSayisiCubit() : super(0);

  var yemeklerRepo = YemeklerRepository();

  Future<void> toplamUrun(String kullanici_adi) async {
    var list = await yemeklerRepo.sepettekiYemekleriGetir(kullanici_adi);
    emit(list.length);
  }
}