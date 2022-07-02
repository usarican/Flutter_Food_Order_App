import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_final_project/Constants/YemeklerConstants.dart';
import 'package:bootcamp_final_project/Cubit/SepetToplamCubit.dart';
import 'package:bootcamp_final_project/Cubit/YemeklerCubit.dart';
import 'package:bootcamp_final_project/Views/FavorilerimEkran%C4%B1.dart';
import 'package:bootcamp_final_project/Views/SepetEkran%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/SepetUrunSayısıCubit.dart';
import '../Model/Yemek.dart';
import '../Services/FirebaseAuth.dart';
import 'YemeklerDetay.dart';


class YemeklerEkran extends StatefulWidget {
  var kullaniciAdi;


  YemeklerEkran({required this.kullaniciAdi});

  @override
  State<YemeklerEkran> createState() => _YemeklerEkranState();
}

class _YemeklerEkranState extends State<YemeklerEkran> {
  String? kullaniciAdi;

  var _authService = AuthService();

  @override
  void initState() {
    super.initState();
    kullaniciBilgileri();
    context.read<YemeklerCubit>().tumYemekleriGetir();
    context.read<UrunSayisiCubit>().toplamUrun(widget.kullaniciAdi);
    context.read<ToplamCubit>().toplamFiyat(widget.kullaniciAdi);
  }

  Future<void> kullaniciBilgileri() async {
    final uid = await FirebaseAuth.instance.currentUser!.uid;
    var authService = AuthService();
    var kullaniciAdi1 = await authService.kullaniciAdiniAl(uid);
    setState((){
      kullaniciAdi = kullaniciAdi1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(kullaniciAdi);
    return Scaffold(
      backgroundColor: YemeklerConstants.backgroundColor,
      appBar: AppBar(
        leading: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: YemeklerConstants.primaryColor,
                ),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "YEDİN",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: YemeklerConstants.pDarkColor,fontFamily: "Lobster"),
                ),
                TextSpan(
                  text: "mi?",style: TextStyle(fontSize: 35,color:Colors.black45,fontFamily: "Lobster" )
                ),
              ]
            )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 5),
            child: Stack(
              children: [
                /*BlocBuilder<UrunSayisiCubit, int>(
                  builder: (context, count) {
                    return Visibility(
                      visible: count > 0 ? true : false,
                      child: Positioned(
                        right: 0.5,
                        top: 0.5,
                        child: Container(
                          width: 17.5,
                          height: 17.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.shade400,
                          ),
                          child: Center(
                              child: Text(
                                "$count",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 10),
                              )),
                        ),
                      ),
                    );
                  },
                ),*/
                IconButton(
                    onPressed: () {
                          _authService.kullaniciCikisi();
                          Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.exit_to_app_outlined,
                      color: YemeklerConstants.primaryColor,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selam ${kullaniciAdi}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: YemeklerConstants.pDarkColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Vollkorn",
                      ),
                    ),
                    const Text(
                      "Yemeğini Bul",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Vollkorn",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: SizedBox(
                  width: 380,
                  height: 50,
                  child: TextField(
                    onChanged: (value){
                      context.read<YemeklerCubit>().yemekAra(value);
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: YemeklerConstants.bottomBarColor,
                      hintText: "Yemek Ara",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey,fontFamily: "Vollkorn"),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                      prefixIconColor: YemeklerConstants.pDarkColor,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              Container(
                width: 420,
                height: 450,
                child: BlocBuilder<YemeklerCubit, List<Yemek>>(
                  builder: (context, yemeklerListesi) {
                    if (yemeklerListesi.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: yemeklerListesi.length,
                          itemBuilder: (context, indeks) {
                            var yemek = yemeklerListesi[indeks];
                            return Card(
                              color: YemeklerConstants.cardColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.favorite_border_outlined)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                                  fit: BoxFit.fill),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Text(
                                            "${yemek.yemek_adi}",
                                            style: const TextStyle(
                                                fontSize: 22.5,
                                                fontWeight: FontWeight.bold,
                                              fontFamily: "Vollkorn"
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "${double.parse(yemek.yemek_fiyat)}₺",
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Vollkorn"
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomRight:
                                                Radius.circular(20),
                                              ),
                                              color: YemeklerConstants
                                                  .primaryColor),
                                          child: Center(
                                            child: SizedBox(
                                              child: IconButton(
                                                splashColor: Colors.transparent,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              YemeklerDetay(
                                                                  yemek:
                                                                  yemek))).then(
                                                          (value) {
                                                            context.read<UrunSayisiCubit>().toplamUrun("UTKU");
                                                            context.read<ToplamCubit>().toplamFiyat("UTKU");
                                                          } );
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
