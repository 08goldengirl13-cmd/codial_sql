import 'package:codial_sql/Model/guruh.dart';
import 'package:codial_sql/pages/Guruhlar/view_groups.dart';
import 'package:flutter/material.dart';

import 'add_group.dart';

class GuruhlarPage extends StatefulWidget {


  String nomi;
  GuruhlarPage({super.key, required this.nomi});

  @override
  State<GuruhlarPage> createState() => _GuruhlarPageState();

}


class _GuruhlarPageState extends State<GuruhlarPage> with SingleTickerProviderStateMixin{
  late TabController tabController;
  List<Groups> ochilayotgan=[];
  List<Groups> ochilganguruhlar =[];

  void GuruhOqish()async{
    List<Groups> list = [];

    ochilayotgan = list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GuruhOqish();
    tabController = TabController(length: 2, vsync: this);
    GuruhOqish();
    tabController.addListener(listenerController);
  }

  int index=0;

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();

  }


  void listenerController(){
    if (!tabController.indexIsChanging) {
      setState(() {
        index = tabController.index;
      });
      print("Tab index :$index");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomi, style: TextStyle(color: Colors.black),),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffFFB800),
        actions: [
          if (tabController.index==1) IconButton(onPressed: ()async{
            var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddGroup( kursNomi: widget.nomi,)));
            if(result){
              setState(() {
                GuruhOqish();
              });
            }
          }, icon: Icon(Icons.add))
        ],
        bottom: TabBar(
            controller: tabController,
            tabs:
            [
              Tab(text: "Ochilgan gurular") ,
              Tab(text: "Ochilayotgan guruhlar") ,
            ]
        ),
      ),
      body: TabBarView(
          controller: tabController,
          children: [
            GuruhBuilder(list: [],),
            GuruhBuilder(list: ochilayotgan,)

          ]),
    );
  }
}



class GuruhBuilder extends StatelessWidget {
  List<Groups> list;
  GuruhBuilder({
    super.key,
    required this.list
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index){
      Groups guruh = list[index];
      return Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom:10, right: 10),
        child: Row(
          children: [
            Column(
              children: [
                Text(guruh.nomi, style: TextStyle(fontSize: 20, color: Color(0xff1A4E79)),),
                Text("O'quvchilar soni: ${guruh.students.length}", style: TextStyle(fontSize: 13 , color: Color(0xff1A4E79)),)
              ],
            ),
            Spacer(),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xff1A4E79),
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Viewguruhpage(guruh: guruh,)));
              }, icon: Icon(Icons.remove_red_eye_outlined, color: Colors.white,)),
            ),
            SizedBox(width: 7),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xffFFB800),
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.white,)),
            ),
            SizedBox(width: 7),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xff1A4E79),
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(onPressed: (){

              }, icon: Icon(Icons.delete_outline_outlined, color: Colors.white,)),
            ),

          ],
        ),
      );
    }, separatorBuilder: (context, index)=>Divider(), itemCount: list.length);
  }
}
