import 'package:cloud_firestore/cloud_firestore.dart';
class Kullanici {
  String email;
  String userName;

  Kullanici({required this.email,required this.userName});

  factory Kullanici.fromSnapshot(DocumentSnapshot snapshot){
    return Kullanici(
        email: snapshot["email"],
        userName: snapshot["userName"],
    );
  }
}