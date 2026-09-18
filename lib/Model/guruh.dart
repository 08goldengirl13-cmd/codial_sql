import 'package:codial_sql/Model/student.dart';

import 'mentor.dart';

class Groups {
  int id;
  String nomi;
  Mentors mentorlar;
  String vaqti;
  String kunlari;
  List<Student> students = [];
  bool ochilganmi;

  Groups({
    required this.id,
    required this.nomi,
    required this.mentorlar,
    required this.vaqti,
    required this.kunlari,
    this.ochilganmi = false});


  factory Groups.fromJson(Map<String, dynamic> map){
    return Groups(id: map["id"],
        nomi: map["nomi"],
        mentorlar: Mentors.fromJson(map["mentorlar"]),
        vaqti: map["vaqti"],
        kunlari: map["kunlari"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomi": nomi,
      "mentorlar": mentorlar.ToMap(),
      "vaqti": vaqti,
      "kunlari": kunlari,
      "ochilganmi": ochilganmi
    };
  }
}