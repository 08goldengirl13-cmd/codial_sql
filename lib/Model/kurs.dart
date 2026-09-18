class Kurs {
  int? id;
  String nomi;
  String kursHaqida;
  String? tarif;

  Kurs({
    this.id,
    required this.nomi,
    required this.kursHaqida,
    this.tarif = " ",
  });

  factory Kurs.fromJson(Map<String, dynamic> map) {
    return Kurs(
      id: map['id'],
      nomi: map['nomi'],
      kursHaqida: map['kurs_haqida'],
      tarif: map['tarif'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomi': nomi,
      'kurs_haqida': kursHaqida,
      'tarif': tarif,
    };
  }
}
