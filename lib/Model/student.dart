class Student {
  String familya;
  String ism;
  String raqam;
  String sana;
  String guruhNomi;

  Student({
    required this.familya,
    required this.ism,
    required this.raqam,
    required this.sana,
    required this.guruhNomi});

  factory Student.fromJson(Map<String, dynamic> map){
    return Student(familya : map["familya"], ism : map["ism"], raqam: map["raqam"], sana : map["sana"], guruhNomi: map["guruhnomi"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "familya": familya,
      "ism": ism,
      "raqam": raqam,
      "sana": sana,
      "guruhnomi": guruhNomi,
    };
  }
}