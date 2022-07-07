import 'package:bootcamp_final_project/Constants/YemeklerConstants.dart';
import 'package:bootcamp_final_project/View_Model/YemeklerRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/SepettekiYemeklerCubit.dart';
import '../Model/Yemek.dart';
import '../Services/FirebaseAuth.dart';


class YemeklerDetay extends StatefulWidget {
  Yemek yemek;

  YemeklerDetay({required this.yemek});

  @override
  State<YemeklerDetay> createState() => _YemeklerDetayState();
}

class _YemeklerDetayState extends State<YemeklerDetay> {
  var yemekSepetteMi = false;
  var yemeklerRepo = YemeklerRepository();
  var foodCounter = 1;

  Future<String> kullaniciBilgileri() async {
    final uid = await FirebaseAuth.instance.currentUser!.uid;
    var authService = AuthService();
    var kullaniciAdi = await authService.kullaniciAdiniAl(uid);
    return kullaniciAdi;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YemeklerConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black45,
            size: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline_sharp,
                  color: Colors.black45,
                  size: 30,
                )),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Container(
                    width: 420, height: 300, color: const Color(0xFFe0e0e0)),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
                        fit: BoxFit.fill,
                      ),
                      color: const Color(0xFFe0e0e0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 400,
              height: 250,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white30,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.yemek.yemek_adi,
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              )),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (foodCounter <= 1) {
                                        Navigator.pop(context);
                                      } else if (foodCounter != 0) {
                                        foodCounter--;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 20,
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "$foodCounter",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      foodCounter++;
                                    });
                                  },
                                  icon: Icon(Icons.add)),
                            ],
                          ),
                        ),
                        Text(
                          "${(foodCounter * int.parse(widget.yemek.yemek_fiyat))}₺",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Spacer(),
                    FutureBuilder(
                      future: kullaniciBilgileri(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          String kullaniciAdi = snapshot.data as String;
                          return Center(
                            child: SizedBox(
                              width: 300,
                              height: 60,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    var list = await yemeklerRepo
                                        .sepettekiYemekleriGetir(kullaniciAdi);
                                    if (list.any((element) =>
                                    element.yemek_adi ==
                                        widget.yemek.yemek_adi)) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => SizedBox(
                                              width: 100,
                                              height: 300,
                                              child: Dialog(
                                                  insetPadding: EdgeInsets.all(10),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                        Alignment.bottomCenter,
                                                        width: double.infinity,
                                                        height: 250,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                            color: Colors.white),
                                                        padding: EdgeInsets.fromLTRB(
                                                            20, 50, 20, 20),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 125.0),
                                                          child: Column(
                                                            children: const [
                                                              Text(
                                                                  "Ürün Sepetinizde Bulunmaktadır.",
                                                                  style: TextStyle(
                                                                      fontSize: 24),
                                                                  textAlign:
                                                                  TextAlign.center),
                                                              Text(
                                                                  "Ürün Sepetinize Eklenememiştir.",
                                                                  style: TextStyle(
                                                                      fontSize: 18),
                                                                  textAlign:
                                                                  TextAlign.center
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 25,
                                                          child: Image.asset(
                                                              "lib/Assets/wrong.png",
                                                              width: 125,
                                                              height: 125))
                                                    ],
                                                  ))));
                                    } else {
                                      context.read<SepetCubit>().sepeteYemekEkleme(
                                        widget.yemek.yemek_adi,
                                        widget.yemek.yemek_resim_adi,
                                        (foodCounter *
                                            int.parse(
                                                widget.yemek.yemek_fiyat))
                                            .toString(),
                                        foodCounter.toString(),
                                        kullaniciAdi,
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (context) => SizedBox(
                                              width: 100,
                                              height: 300,
                                              child: Dialog(
                                                  backgroundColor: Colors.transparent,
                                                  insetPadding: EdgeInsets.all(10),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                        Alignment.bottomCenter,
                                                        width: double.infinity,
                                                        height: 250,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                            color: Colors.white),
                                                        padding: EdgeInsets.fromLTRB(
                                                            20, 50, 20, 20),
                                                        child: const Text(
                                                            "Ürün Sepetinize Eklenmiştir.",
                                                            style: TextStyle(
                                                                fontSize: 24),
                                                            textAlign:
                                                            TextAlign.center),
                                                      ),
                                                      Positioned(
                                                          top: 25,
                                                          child: Image.asset(
                                                              "lib/Assets/done.png",
                                                              width: 125,
                                                              height: 125))
                                                    ],
                                                  ))));
                                    }
                                  },
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        YemeklerConstants.pDarkColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Sepete Ekle",
                                    style: TextStyle(fontSize: 30),
                                  )),
                            ),
                          );
                        }
                        else if(snapshot.hasError){
                          return Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("lib/Assets/wrong.png"),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          return const Center(
                              child: CircularProgressIndicator(
                                color: YemeklerConstants.pDarkColor,
                                backgroundColor: YemeklerConstants.backgroundColor,
                              )
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
