import 'package:bootcamp_final_project/Constants/YemeklerConstants.dart';
import 'package:bootcamp_final_project/Views/Kay%C4%B1tEkran%C4%B1.dart';
import 'package:flutter/material.dart';

import '../Services/FirebaseAuth.dart';
import 'AnaEkran.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  var tfEmailController = TextEditingController();
  var tfPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.85,
            height: size.height * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange.shade200.withOpacity(0.75),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.75),
                      blurRadius: 10,
                      spreadRadius: 2)
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: "YEDİN",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: YemeklerConstants.pDarkColor,
                          fontFamily: "Lobster"),
                    ),
                    TextSpan(
                        text: "mi?",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontFamily: "Lobster")),
                  ])),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 25,bottom: 10),
                    child: TextField(
                      controller: tfEmailController,
                      decoration: InputDecoration(
                        hintText: "E-Mail",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixText: ' ',
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.deepOrange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
                    child: TextField(
                      controller: tfPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Şifre",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.deepOrange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      _authService
                          .kullaniciGirisi(
                          tfEmailController.text, tfPasswordController.text)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnaEkran()));
                      });
                    },
                    child: Container(
                      width: size.width*0.75,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(  color: YemeklerConstants.pDarkColor, width: 2),
                          //color: colorPrimaryShade,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                            child: Text(
                              "Giriş yap",
                              style: TextStyle(
                                color: YemeklerConstants.pDarkColor,
                                fontSize: 20,
                              ),
                            ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => KayitEkrani()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1,
                          width: 75,
                          color: Colors.black45
                        ),
                        const Text(
                          "Kayıt ol",
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          height: 1,
                          width: 75,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
