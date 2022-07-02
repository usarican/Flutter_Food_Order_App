import 'package:bootcamp_final_project/Cubit/SepetToplamCubit.dart';
import 'package:bootcamp_final_project/Cubit/SepetUrunSay%C4%B1s%C4%B1Cubit.dart';
import 'package:bootcamp_final_project/Cubit/YemeklerCubit.dart';
import 'package:bootcamp_final_project/Views/GirisEkran%C4%B1.dart';
import 'package:bootcamp_final_project/Model/Yemek.dart';
import 'package:bootcamp_final_project/Views/AnaEkran.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/SepettekiYemeklerCubit.dart';
import 'Model/SepetYemek.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => YemeklerCubit(<Yemek>[])),
        BlocProvider(create: (context) => SepetCubit()),
        BlocProvider(create: (context) => UrunSayisiCubit()),
        BlocProvider(create: (context) => ToplamCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const GirisEkrani(),
      ),
    );
  }
}

