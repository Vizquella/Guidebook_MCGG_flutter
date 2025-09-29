import 'package:flutter/material.dart';

void main() {
  runApp(const MagicChessApp());
}

class MagicChessApp extends StatelessWidget {
  const MagicChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guidebook MagicChess GoGo",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Guidebook MagicChess GoGo"),
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Xborg",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Role: Defender"),
                  Text("Faction: Metro Zero"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Saber",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Role: Swordsman"),
                  Text("Faction: Starwing"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Angela",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Role: Mage"),
                  Text("Synergy: Aspirant"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}