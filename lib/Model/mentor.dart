class Mentors {
  int? id;
  String ism;
  String familya;
  String raqam;
  int kurs_id;

  Mentors({
    this.id,
    required this.ism,
    required this.familya,
    required this.raqam,
    required this.kurs_id,
  });

  factory Mentors.fromJson(Map<String, dynamic> map) {
    return Mentors(
      id: map["id"],
      ism: map["ism"],
      familya: map["familya"],
      raqam: map["raqam"],
      kurs_id: map["kurs_id"],
    );
  }

  Map<String, dynamic> ToMap() {
    return {
      "id": id,
      "ism": ism,
      "familya": familya,
      "raqam": raqam,
      "kurs_id": kurs_id,
    };
  }
}
