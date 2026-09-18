import 'package:flutter/material.dart';

import '../../Model/guruh.dart';
import '../../Model/student.dart';


class Viewguruhpage extends StatefulWidget {
  Groups guruh;
  Viewguruhpage({super.key, required this.guruh, });

  @override
  State<Viewguruhpage> createState() => _ViewguruhpageState();
}

class _ViewguruhpageState extends State<Viewguruhpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.guruh.nomi, style: TextStyle(color: Colors.black) ,),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffFFB800),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(widget.guruh.nomi, style: TextStyle(color:  Color(0xff1A4E79), fontSize: 20),),
            Text("O'quvchilar soni: ${widget.guruh.students.length}",style: TextStyle(color:  Color(0xff1A4E79), fontSize: 20)),
            Text("Vaqti: ${widget.guruh.vaqti}",style: TextStyle(color:  Color(0xff1A4E79), fontSize: 20)),
            ElevatedButton(onPressed: ()async{
            }, child: Text("Guruhga darsni boshlash"), style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xffFFB800),
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 37),
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(5),
                )
            )),
            Text("Barcha guruhlar ro'yxati", style: TextStyle(color:  Color(0xff1A4E79), fontSize: 20, fontWeight: FontWeight.bold ),),
            Expanded(child: ListView.separated(itemBuilder: (context, index){
              Student student = widget.guruh.students[index];
              return Row(
                children: [
                  Text("${student.ism} ${student.familya}", style: TextStyle(fontSize: 20),),
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
              );
            }, separatorBuilder: (context, index)=>Divider(), itemCount: widget.guruh.students.length))
          ],
        ),
      ),
    );
  }
}
