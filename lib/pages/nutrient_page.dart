import 'package:flutter/material.dart';
import '../api/nutrient_api.dart';
import '../models/nutrient_model.dart';

class NutrientPage extends StatelessWidget {
  final int recipeId;
  final String title;
  final String apiKey;

  const NutrientPage({
    super.key,
    required this.recipeId,
    required this.apiKey,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Nutrient>>(
        future: NutrientApi().fetchNutrients(recipeId, apiKey),
        builder: (context, snapshot) {
          Widget body;

          if (snapshot.connectionState == ConnectionState.waiting) {
            body = const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            body = Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            body = const Center(child: Text('No nutrient data found.'));
          } else {
            final nutrients = snapshot.data!;

            body = Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: nutrients.length,
                itemBuilder: (context, index) {
                  final nutrient = nutrients[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(nutrient.name, style: const TextStyle(fontSize: 16))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${nutrient.amount.toStringAsFixed(2)} ${nutrient.unit}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${nutrient.percentOfDailyNeeds.toStringAsFixed(1)}% Daily',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                color: Colors.teal.shade400,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: body),
            ],
          );
        },
      ),
    );
  }
}
