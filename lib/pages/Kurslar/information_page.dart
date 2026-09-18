import 'package:flutter/material.dart';

import '../../Model/kurs.dart';

class InformationPage extends StatelessWidget {
  Kurs kurs;
  InformationPage({super.key, required this.kurs}){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kurs.nomi),
        backgroundColor: Color(0xffFFB800),
        foregroundColor: Colors.white,
      ),
      body: Padding(padding: EdgeInsets.all(10),
        child:  Text(kurs.kursHaqida),
      ),
    );
  }
}
