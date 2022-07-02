import 'package:flutter/material.dart';

import '../Constants/YemeklerConstants.dart';
import 'AnaEkran.dart';
import 'SepetEkranı.dart';

class Favorilerim extends StatefulWidget {
  const Favorilerim({Key? key}) : super(key: key);

  @override
  State<Favorilerim> createState() => _FavorilerimState();
}

class _FavorilerimState extends State<Favorilerim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: "FAVORILER",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: YemeklerConstants.pDarkColor,fontFamily: "Lobster"),
                  ),
                  TextSpan(
                      text: "IM",style: TextStyle(fontSize: 25,color:Colors.black45,fontFamily: "Lobster" )
                  ),
                ]
            )
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("FAVORILERIM"),
          ],
        ),
      ),
    );
  }
}
