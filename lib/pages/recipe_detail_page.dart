import 'package:flutter/material.dart';
import 'package:mealmate/models/recipe_model.dart';
import 'package:mealmate/api/recipe_detail_api.dart';
import 'package:mealmate/pages/nutrient_page.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;
  final String apiKey;

  const RecipeDetailPage({Key? key, required this.recipeId, required this.apiKey}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Future<RecipeModel> _recipeFuture;

  @override
  void initState() {
    super.initState();
    _recipeFuture = RecipeDetailApi().fetchRecipeInformation(widget.recipeId, widget.apiKey);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text("Recipe Detail"),
      ),
      body: FutureBuilder<RecipeModel>(
        future: _recipeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final recipe = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ภาพอาหาร + ปุ่ม Favorite + ปุ่ม
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: recipe.image.isNotEmpty
                          ? Image.network(
                              recipe.image,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.fastfood, size: 80, color: Colors.grey),
                    ),
                    const Positioned(
                      top: 16,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NutrientPage(
                                recipeId: widget.recipeId,
                                apiKey: widget.apiKey,
                                title: recipe.title,
                              ),
                            ),
                          );
                        },
                        child: const Text("Show Nutrient  >"),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Dish Types: ${recipe.dishTypes.join(', ')}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      if (recipe.vegetarian)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Vegetarian',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildTimeCard('Ready in', '${recipe.readyInMinutes} min'),
                      const SizedBox(width: 16),
                      _buildTimeCard(
                        'preparation ${recipe.preparationMinutes ?? "-"} min\ncooking ${recipe.cookingMinutes ?? "-"} min',
                        '',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: recipe.extendedIngredients.map((ingredient) {
                      return Card(
                        child: ListTile(
                          title: Text(ingredient.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ingredient.aisle ?? ""),
                              Text(
                                '${ingredient.amount} ${ingredient.unit ?? ""}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeCard(String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple.shade100),
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
