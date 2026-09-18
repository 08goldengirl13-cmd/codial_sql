import 'package:codial_sql/pages/Kurslar/kurslar_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/fon.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
          Positioned(
              top: 5,
              right: 5,
              child:Image.asset("assets/images/image 1.png") ),
          Positioned(
              bottom: 5,
              left: 5,
              child: Image.asset("assets/images/codial.uz.png")),
          Positioned(
              top: 137,
              left: 25,
              child: buttoncha(title: "Kurslar", image: "assets/images/online-course 1.png", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Kurslarpage(index: 1)));
              })),
          Positioned(
              top: 262,
              left: 130,
              child: buttoncha(title: "Guruhlar", image: "assets/images/people1.png", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Kurslarpage(index: 2)));

              })  ),
          Positioned(
              top: 399,
              left: 231,
              child: buttoncha(title: "Mentorlar", image: "assets/images/Group.png", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Kurslarpage(index: 3)));

              }))
        ],
      ),
    );
  }
}

class buttoncha extends StatelessWidget {
  String title;
  String image;
  VoidCallback onTap;

   buttoncha({
     required this.title,
     required this.image,
     required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
        },
      child: Container(
        width: 105,
        height: 90,
        decoration: BoxDecoration(
          color: Color(0xff1A4E79),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,
              height: 34,
              width: 34,),
            Text(title, style: TextStyle(fontSize: 18, color: Color(0xffFFB800)),)
          ],
        ),
      ),
    );
  }
}
