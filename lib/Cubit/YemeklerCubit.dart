import 'package:bootcamp_final_project/View_Model/YemeklerRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/Yemek.dart';

class YemeklerCubit extends Cubit<List<Yemek>>{
  YemeklerCubit(super.initialState);

  var yemeklerRepo = YemeklerRepository();

  Future<void> tumYemekleriGetir() async {
    var list = await yemeklerRepo.tumYemekleriGetir();
    emit(list);
  }

  Future<void> yemekAra(String aramaKelimesi) async {
    var arananlarListesi = <Yemek>[];
    var list = await yemeklerRepo.tumYemekleriGetir();
    for(int i=0;i<list.length;i++){
      if(list.elementAt(i).yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase())){
        arananlarListesi.add(list.elementAt(i));
      }
    }
    emit(arananlarListesi);
  }


}