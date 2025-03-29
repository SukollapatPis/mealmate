import 'package:flutter/material.dart';
import 'package:mealmate/api/wine_api.dart';
import 'package:mealmate/models/wine_pairing_model.dart';
import 'package:mealmate/pages/wine_not_pairing_page.dart';
import 'package:mealmate/pages/not_found_page.dart';

class WinePairingPage extends StatefulWidget {
  final String wineName;

  const WinePairingPage({required this.wineName});

  @override
  _WinePairingPageState createState() => _WinePairingPageState();
}

class _WinePairingPageState extends State<WinePairingPage> {
  late Future<WinePairingModel> pairingData;

  @override
  void initState() {
    super.initState();
    pairingData = WineApi().getDishPairingsForWine(widget.wineName);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wineName.capitalize()),
        backgroundColor: colorScheme.primary,
      ),
      body: FutureBuilder<WinePairingModel>(
        future: pairingData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // ส่งไปยัง NotFoundPage เมื่อเกิดข้อผิดพลาด
            // return NotFoundPage();
            return WineNotPairingPage();
          } else if (snapshot.hasData) {
            var pairing = snapshot.data!;
            if (pairing.pairings.isEmpty || pairing.text.contains("No dish pairings found for wine pinot_blanc")) {
              // ส่งไปยัง WineNotPairingPage เมื่อไม่มีการจับคู่ไวน์
              return WineNotPairingPage();
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.wineName.capitalize(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text("Pairings", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  ...pairing.pairings.map((pairing) => Text("• $pairing")).toList(),
                  const SizedBox(height: 16),
                  Text(
                    pairing.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            // แสดงหน้า NotFoundPage กรณีไม่มีข้อมูล
            return NotFoundPage();
          }
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}