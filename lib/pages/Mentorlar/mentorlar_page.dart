import 'package:codial_sql/Model/kurs.dart';
import 'package:flutter/material.dart';

import '../../Model/mentor.dart';
import '../../service/db/database_service.dart';
import 'add_mentor.dart';

class MentorsPage extends StatefulWidget {
  Kurs kurs;
  MentorsPage({super.key, required this.kurs});

  @override
  State<MentorsPage> createState() => _MentorsPageState();
}

class _MentorsPageState extends State<MentorsPage> {
  DatabaseService databaseService = DatabaseService.instance;
  List<Mentors> mentors =[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void readMentor(){
    databaseService.getMentors().then((value) {
      setState(() {
        mentors = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFB800),
        foregroundColor: Colors.white,
        title: Text(widget.kurs.nomi, style: TextStyle(color: Colors.black)),
        actions: [IconButton(onPressed: ()async {
          var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMentor(kurs: widget.kurs,)));
          if(result==Icons.trending_up){
            setState(() {
            });
          }
        }, icon: Icon(Icons.add))],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Mentors mentor = mentors[index];
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text("${mentor.ism} ${mentor.familya}", style: TextStyle(fontSize: 20),),
                Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffFFB800),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.white,)),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff1A4E79),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(onPressed: (){
                  }, icon: Icon(Icons.delete_outline_outlined, color: Colors.white,)),
                )

              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: mentors.length,
      ),
    );
  }
}
