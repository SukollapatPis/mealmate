import 'package:flutter/material.dart';
import 'restaurant_result_page.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  String? selectedCuisine = "Thai";
  String? selectedContinent;
  String? selectedCountry;

  final cuisines = ['Thai', 'Italian', 'Chinese', 'Japanese'];
  final continents = ['Asia', 'Europe', 'North America'];

  final Map<String, List<Map<String, dynamic>>> countriesByContinent = {
    'Asia': [
      {'name': 'Thailand', 'lat': 13.7563, 'lng': 100.5018},
      {'name': 'Japan', 'lat': 35.6762, 'lng': 139.6503},
      {'name': 'Korea', 'lat': 37.5665, 'lng': 126.9780},
      {'name': 'China', 'lat': 39.9042, 'lng': 116.4074},
    ],
    'Europe': [
      {'name': 'Italy', 'lat': 41.9028, 'lng': 12.4964},
      {'name': 'France', 'lat': 48.8566, 'lng': 2.3522},
    ],
    'North America': [
      {'name': 'US', 'lat': 37.78129959, 'lng': -122.38869477},
      {'name': 'Canada', 'lat': 56.1304, 'lng': -106.3468},
    ],
  };

  List<Map<String, dynamic>> getAvailableCountries() {
    return countriesByContinent[selectedContinent] ?? [];
  }

  void onSearch() {
    if (selectedCuisine != null && selectedContinent != null && selectedCountry != null) {
      final selectedData = getAvailableCountries().firstWhere((e) => e['name'] == selectedCountry);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantResultPage(
            cuisine: selectedCuisine!,
            lat: selectedData['lat'],
            lng: selectedData['lng'],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select cuisine, continent, and country.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final countryList = getAvailableCountries();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 44, 116, 109),
        title: const Text('Find Restaurants'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cuisine"),
            DropdownButton<String>(
              value: selectedCuisine,
              isExpanded: true,
              onChanged: (value) => setState(() => selectedCuisine = value),
              items: cuisines.map((cuisine) {
                return DropdownMenuItem(
                  value: cuisine,
                  child: Text(cuisine),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Continent"),
            Wrap(
              spacing: 8,
              children: continents.map((continent) {
                return ChoiceChip(
                  label: Text(continent),
                  selected: selectedContinent == continent,
                  onSelected: (_) => setState(() {
                    selectedContinent = continent;
                    selectedCountry = null;
                  }),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (countryList.isNotEmpty) ...[
              const Text("Country"),
              Wrap(
                spacing: 8,
                children: countryList.map((country) {
                  return ChoiceChip(
                    label: Text(country['name']),
                    selected: selectedCountry == country['name'],
                    onSelected: (_) => setState(() {
                      selectedCountry = country['name'];
                    }),
                  );
                }).toList(),
              ),
            ],
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
