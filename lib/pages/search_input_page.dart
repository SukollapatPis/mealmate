import 'package:flutter/material.dart';

class SearchInputPage extends StatefulWidget {
  @override
  _SearchInputPageState createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage> {
  String searchText = "";
  String selectedCuisine = "Thai";
  String selectedDishType = "All";

  final List<String> cuisines = [
    "African",
    "Asian",
    "American",
    "British",
    "Cajun",
    "Caribbean",
    "Chinese",
    "Eastern European",
    "European",
    "French",
    "German",
    "Greek",
    "Indian",
    "Irish",
    "Italian",
    "Japanese",
    "Jewish",
    "Korean",
    "Latin American",
    "Mediterranean",
    "Mexican",
    "Middle Eastern",
    "Nordic",
    "Southern",
    "Spanish",
    "Thai",
    "Vietnamese",
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
    "Sauce",
    "Marinade",
    "Fingerfood",
    "Snack",
    "Drink",
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
            // Search Text Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
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
                        // ส่งข้อมูลกลับไปยังหน้า HomePage
                        Navigator.pop(context, {
                          'searchText': searchText,
                          'cuisine': selectedCuisine,
                          'dishType': selectedDishType,
                        });
                      },
                      child: const Text('Search',
                          style: TextStyle(color: Colors.white)),
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
