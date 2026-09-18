import 'package:codial_sql/Model/kurs.dart';
import 'package:flutter/material.dart';

import '../../Model/mentor.dart';
import '../../service/db/database_service.dart';

class AddMentor extends StatefulWidget {
  final Kurs kurs;

  const AddMentor({super.key, required this.kurs});

  @override
  State<AddMentor> createState() => _AddMentorState();
}

class _AddMentorState extends State<AddMentor> {
  late TextEditingController ismController;
  late TextEditingController familyaController;
  late TextEditingController raqamController;
  List<Mentors> mentorlar = [];
  DatabaseService databaseService = DatabaseService.instance;

  void addMentor() async {
    if (ismController.text.trim().isEmpty ||
        familyaController.text.trim().isEmpty ||
        raqamController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iltimos, barcha maydonlarni to'ldiring!")),
      );
      return;
    }

    if (widget.kurs.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kurs ID topilmadi!")),
      );
      return;
    }

    Mentors mentors = Mentors(
      ism: ismController.text.trim(),
      familya: familyaController.text.trim(),
      raqam: raqamController.text.trim(),
      kurs_id: widget.kurs.id!,
    );

    await databaseService.insertMentor(mentors);
    if (mounted) {
      Navigator.pop(context, true);
    }
    print("Mentor qo'shildi----------------");
  }

  void readMentor() {
    databaseService.getMentors().then((value) {
      setState(() {
        mentorlar = value;
      });
    });
  }

  @override
  void dispose() {
    ismController.dispose();
    familyaController.dispose();
    raqamController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ismController = TextEditingController();
    familyaController = TextEditingController();
    raqamController = TextEditingController();
    readMentor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentor qo'shish", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xffFFB800),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: familyaController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Familyasi",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: ismController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Ism",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: raqamController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Telefon raqam",
              ),
            ),
            const Spacer(),
            Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                color: const Color(0xff0A252F),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  addMentor();
                },
                child: const Text("Qo'shish", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
