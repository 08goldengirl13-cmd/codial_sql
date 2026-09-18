import 'dart:core';

import 'package:flutter/material.dart';

import '../../Model/mentor.dart';

class AddGroup extends StatefulWidget {
  String kursNomi;
  int index =0;

  AddGroup( {super.key,required this.kursNomi });




  @override
  State<AddGroup> createState() => _AddGroupState();

}

class _AddGroupState extends State<AddGroup> {
  late TextEditingController nomiController;

  List<Mentors> list = [];

  List<String> kunlar = [
    "Dushanba - Chorshanba - Juma",
    "Seshanba - Payshanba - Shanba"
  ];

  List<String>  vaqtlar =[
    "8:00-10:00",
    "10:00-12:00",
    "14:00-16:00",
    "16:00-18:00",
  ];

  Mentors? tanlanganMentor ;
  String tanlanganVaq="" ;
  String tanlanganKun="" ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomiController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nomiController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFB800),
        foregroundColor: Colors.white,
        title: Text("Yangi guruh yaratish", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: .end,
          children: [
            TextField(
              controller: nomiController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Guruh nomi",
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField<Mentors>(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff989595,), width: 1),
                    ),
                    filled: true,
                    fillColor: Color(0xffE2DFDF),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                ),
                isExpanded: true,
                value: tanlanganMentor,
                items: list.map<DropdownMenuItem<Mentors>>((Mentors mentor){
                  return DropdownMenuItem(
                      value: mentor,
                      child: Text("${mentor.familya} ${mentor.ism}"));
                }).toList(),
                onChanged: (Mentors? volue){
                  setState(() {
                    tanlanganMentor = volue!;
                  });
                }),
            SizedBox(height: 10,),
            DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff989595,), width: 1),
                    ),
                    filled: true,
                    fillColor: Color(0xffE2DFDF),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                ),
                items: vaqtlar.map<DropdownMenuItem<String>>((String vaqt){
                  return DropdownMenuItem(
                      value: vaqt,
                      child: Text(vaqt));
                }).toList(),
                onChanged: (String? value){
                  setState(() {
                    tanlanganVaq = value! ;
                  });
                }),
            SizedBox(height: 10,),
            DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff989595,), width: 1),
                    ),
                    filled: true,
                    fillColor: Color(0xffE2DFDF),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                ),
                items: kunlar.map<DropdownMenuItem<String>>((String kun){
                  return DropdownMenuItem(
                      value: kun,
                      child: Text(kun));
                }).toList(),
                onChanged: (String? value){
                  setState(() {
                    tanlanganKun = value!;
                  });
                }),
            Spacer(),
            ElevatedButton(onPressed: (){
              widget.index++;
            }, child: Text("Saqlash"),
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                borderRadius: .circular(10),
              ),
                backgroundColor: Color(0xffFFB800),
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
