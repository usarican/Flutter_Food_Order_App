import 'package:bootcamp_final_project/Constants/YemeklerConstants.dart';
import 'package:bootcamp_final_project/Cubit/SepetToplamCubit.dart';
import 'package:bootcamp_final_project/Cubit/YemeklerCubit.dart';
import 'package:bootcamp_final_project/Model/KullaniciBilgisi.dart';
import 'package:bootcamp_final_project/Services/FirebaseAuth.dart';
import 'package:bootcamp_final_project/Views/FavorilerimEkran%C4%B1.dart';
import 'package:bootcamp_final_project/Views/SepetEkran%C4%B1.dart';
import 'package:bootcamp_final_project/Views/YemeklerEkran%C4%B1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/SepetUrunSayısıCubit.dart';
import '../Model/Yemek.dart';
import 'YemeklerDetay.dart';

class AnaEkran extends StatefulWidget {
  AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {

  var secilenIndex = 0;
  var sayfaListesi = [
    YemeklerEkran(kullaniciAdi: "UTKU"),
    Sepetim()
  ];

  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: YemeklerConstants.backgroundColor,
      body: sayfaListesi[secilenIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: YemeklerConstants.bottomBarColor,
        currentIndex: secilenIndex,
        onTap: (index) => setState(() => secilenIndex = index),
        selectedItemColor: Colors.orange.shade400,
        unselectedItemColor: Colors.black38,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                secilenIndex == 0 ? Icons.home : Icons.home_outlined,
                size: 35,
              ),
              label: "Ana Ekran"),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    secilenIndex == 1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    size: 35,
                  ),
                  BlocBuilder<UrunSayisiCubit, int>(
                    builder: (context, count) {
                      return Visibility(
                        visible: count > 0  ? true : false,
                        child: Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange.withOpacity(0.7),
                            ),
                            child: Center(
                                child: Text(
                              "$count",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<ToplamCubit, double>(
                    builder: (context, count) {
                      return Visibility(
                        visible: count > 0 && secilenIndex == 1 ? true : false,
                        child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.orange.withOpacity(0.7),
                            ),
                            child: Center(
                                child: Text(
                              "$count",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              label: "Sepetim"),
        ],
      ),
    );
  }
}
