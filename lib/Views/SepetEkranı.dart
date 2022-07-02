import 'package:bootcamp_final_project/Constants/YemeklerConstants.dart';
import 'package:bootcamp_final_project/Cubit/SepetToplamCubit.dart';
import 'package:bootcamp_final_project/Cubit/SepetUrunSay%C4%B1s%C4%B1Cubit.dart';
import 'package:bootcamp_final_project/Cubit/SepettekiYemeklerCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/SepetYemek.dart';
import 'AnaEkran.dart';
import 'FavorilerimEkranı.dart';

class Sepetim extends StatefulWidget {
  const Sepetim({Key? key}) : super(key: key);

  @override
  State<Sepetim> createState() => _SepetimState();
}

class _SepetimState extends State<Sepetim> {
  var toplamFiyat;
  void initState() {
    super.initState();
    context.read<SepetCubit>().sepettekiYemekleriGetir("UTKU");
    context.read<ToplamCubit>().toplamFiyat("UTKU");
    context.read<UrunSayisiCubit>().toplamUrun("UTKU");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YemeklerConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AnaEkran()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black45,
            size: 30,
          ),
        ),
        title: RichText(
            text: const TextSpan(
                children: [
                  TextSpan(
                    text: "SEPET",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: YemeklerConstants.pDarkColor,fontFamily: "Lobster"),
                  ),
                  TextSpan(
                      text: "IM",style: TextStyle(fontSize: 35,color:Colors.black45,fontFamily: "Lobster" )
                  ),
                ]
            )
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 1),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: BlocBuilder<UrunSayisiCubit, int>(
                builder: (context, count) {
                  return Center(
                      child: Text(
                    "$count",
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SepetCubit, List<SepetYemek>>(
          builder: (context, sepettekiYemeklerListesi) {
            if (sepettekiYemeklerListesi.isNotEmpty) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 400,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: sepettekiYemeklerListesi.length,
                          itemBuilder: (context, indeks) {
                            var sepettekiYemek = sepettekiYemeklerListesi[indeks];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0,left: 5.0),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://kasimadalan.pe.hu/yemekler/resimler/${sepettekiYemek.yemek_resim_adi}"),
                                              fit: BoxFit.fill),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${sepettekiYemek.yemek_siparis_adet}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                                      child: Text(
                                        "x",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${sepettekiYemek.yemek_adi}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${double.parse(sepettekiYemek.yemek_fiyat)}₺",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: (){
                                          context.read<SepetCubit>().sepettenYemekSilme(sepettekiYemek.sepet_yemek_id, sepettekiYemek.kullanici_adi).then(
                                                  (value) {
                                                    context.read<UrunSayisiCubit>().toplamUrun(sepettekiYemek.kullanici_adi);
                                                    context.read<ToplamCubit>().toplamFiyat(sepettekiYemek.kullanici_adi);
                                                  });
                                        },
                                        icon: Icon(Icons.delete_outline_outlined,color: Colors.grey.shade600,),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: YemeklerConstants.pDarkColor,
                                  thickness: 2,
                                  height: 1,
                                  indent: 20,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 420,
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Toplam",
                                  style: TextStyle(
                                      fontSize: 40, fontWeight: FontWeight.bold),
                                ),
                                BlocBuilder<ToplamCubit, double>(
                                  builder: (context, count) {
                                    return Text(
                                      "$count₺",
                                      style: const TextStyle(
                                          fontSize: 40, fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Spacer(),
                            Center(
                              child: SizedBox(
                                width: 300,
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              YemeklerConstants.pDarkColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.attach_money_rounded,
                                          size: 30,
                                        ),
                                        Text(
                                          "Öde",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            else  {
              return const Center(
                child: Text("Yemek Sepeti Boş",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w500,color: Colors.grey),),
              );
            }
          },
        ),
      ),
    );
  }
}
