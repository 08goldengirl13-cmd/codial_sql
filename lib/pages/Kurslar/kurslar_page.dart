import 'package:flutter/material.dart';

import '../../Model/kurs.dart';
import '../../service/db/database_service.dart';
import '../Guruhlar/guruhlar_page.dart';
import '../Mentorlar/mentorlar_page.dart';
import 'information_page.dart';


class Kurslarpage extends StatefulWidget {
  int index;

  Kurslarpage({super.key, required this.index});

  @override
  State<Kurslarpage> createState() => _KurslarpageState();
}

class _KurslarpageState extends State<Kurslarpage> {
  DatabaseService databaseService = DatabaseService.instance;
  List<Kurs> list = [];
  late TextEditingController nomiController;
  late TextEditingController haqidaController;



  @override
  void initState() {
    super.initState();
    nomiController = TextEditingController();
    haqidaController= TextEditingController();
    readKurs();
  }

  @override
  void dispose() {
    nomiController.dispose();
    haqidaController.dispose();
    super.dispose();
  }

  void readKurs(){
    databaseService.getKurslar().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  void addKurs(){
    Kurs newKurs = Kurs(nomi:nomiController.text , kursHaqida: haqidaController.text);
    databaseService.insertKurs(newKurs);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Barcha kurslar ro'yxati",
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffFFB800),
        actions: [
          if (widget.index==1) IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: .zero),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: .min,
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
                              hintText: "Kurs nomi",
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: haqidaController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: "Kurs haqida",
                            ),
                          ),

                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: .end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Yopish"),
                              ),
                              TextButton(
                                onPressed: () {
                                  addKurs();
                                  setState(() {
                                    readKurs();
                                  });

                                },
                                child: Text(
                                  "Qo'shish",
                                  style: TextStyle(color: Color(0xffFFB800)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Kurs kurs = list[index];
          return Card(
            color: Color(0xffFFB800),
            child: ListTile(
              title: Text(kurs.nomi),
              trailing: IconButton(
                onPressed: () {
                  switch(widget.index){
                    case 1:  Navigator.push(context, MaterialPageRoute(builder: (context)=>InformationPage(kurs: kurs,))); break;
                    case 2:  Navigator.push(context, MaterialPageRoute(builder: (context)=>GuruhlarPage(nomi: kurs.nomi))); break;
                    case 3:  Navigator.push(context, MaterialPageRoute(builder: (context)=>MentorsPage(kurs: kurs,))); break;
                  }
                },
                icon: Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
    );
  }
}
