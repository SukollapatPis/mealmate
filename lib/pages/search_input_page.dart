import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}
//

class _SearchPageState extends State<SearchPage> {
  String selectedCuisine = "Thai";
  String selectedDishType = "All";

  final List<String> cuisines = [
    "Thai",
    "Japanese",
    "Italian",
    "Indian",
    "Chinese",
    "French"
  ];

  final List<String> dishTypes = [
    "All",
    "Main course",
    "Side dish",
    "Dessert",
    "Appetizer",
    "Salad",
    "Bread",
    "Breakfast",
    "Soup",
    "Beverage",
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search of recipes name',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Cuisines'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedCuisine,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCuisine = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          items: cuisines.map((String cuisine) {
                            return DropdownMenuItem<String>(
                              value: cuisine,
                              child: Text(cuisine),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Dish Types'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedDishType,
                          onChanged: (String? value) {
                            setState(() {
                              selectedDishType = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          items: dishTypes.map((String dishType) {
                            return DropdownMenuItem<String>(
                              value: dishType,
                              child: Text(dishType),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        print("Searching: $selectedCuisine, $selectedDishType");
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
