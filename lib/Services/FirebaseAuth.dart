import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/KullaniciBilgisi.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> kullaniciGirisi(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  kullaniciCikisi() async {
    return await _auth.signOut();
  }

  Future<User?> yeniKullanici(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("Person")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email});

    return user.user;
  }
  Future<String> kullaniciAdiniAl(String uid) async {
    final docSnapshot = await FirebaseFirestore.instance.collection("Person").doc(uid).get();
    var data = docSnapshot.data() as Map<String,dynamic>;
    return data["userName"];
  }
}