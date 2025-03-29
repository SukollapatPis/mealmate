import 'package:flutter/material.dart';
import 'package:mealmate/pages/wine_pairing_page.dart';

class WinePage extends StatelessWidget {
  final Map<String, List<String>> wineCategories = {
    "White Wine": [
      "assyrtiko",
      "pinot_blanc",
      "cortese",
      "roussanne",
      "moschofilero",
      "muscadet",
      "viognier",
      "verdicchio",
      "greco",
      "marsanne",
      "white_burgundy",
      "chardonnay",
      "gruener_veltliner",
      "trebbiano",
      "sauvignon_blanc",
      "catarratto",
      "albarino",
      "arneis",
      "verdejo",
      "vermentino",
      "soave",
      "pinot_grigio",
      "dry_riesling",
      "torrontes",
      "mueller_thurgau",
      "grechetto",
      "gewurztraminer",
      "chenin_blanc",
      "white_bordeaux",
      "semillon",
      "riesling",
      "sauternes",
      "sylvaner",
      "lillet_blanc",
    ],
    "Red Wine": [
      "petite_sirah",
      "zweigelt",
      "baco_noir",
      "bonarda",
      "cabernet_franc",
      "bairrada",
      "barbera_wine",
      "primitivo",
      "pinot_noir",
      "nebbiolo",
      "dolcetto",
      "tannat",
      "negroamaro",
      "red_burgundy",
      "corvina",
      "rioja",
      "cotes_du_rhone",
      "grenache",
      "malbec",
      "zinfandel",
      "sangiovese",
      "carignan",
      "carmenere",
      "cesanese",
      "cabernet_sauvignon",
      "aglianico",
      "tempranillo",
      "shiraz",
      "mourvedre",
      "merlot",
      "nero_d_avola",
    ],
    "Dessert Wine": [
      "pedro_ximenez",
      "moscato",
      "late_harvest",
      "ice_wine",
      "white_port",
      "lambrusco_dolce",
      "madeira",
      "banyuls",
      "vin_santo",
      "port",
    ],
    "Sparkling Wine": [
      "cava",
      "cremant",
      "champagne",
      "prosecco",
      "spumante",
      "sparkling_rose",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Wine Guide'),
        backgroundColor: colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: wineCategories.keys.length,
          itemBuilder: (context, index) {
            String category = wineCategories.keys.elementAt(index);
            List<String> wines = wineCategories[category]!;
            IconData categoryIcon;

            // กำหนดไอคอนตามหมวดหมู่
            switch (category) {
              case "White Wine":
                categoryIcon = Icons.wine_bar;
                break;
              case "Red Wine":
                categoryIcon = Icons.local_drink;
                break;
              case "Dessert Wine":
                categoryIcon = Icons.cake;
                break;
              case "Sparkling Wine":
                categoryIcon = Icons.bubble_chart;
                break;
              default:
                categoryIcon = Icons.local_drink;
            }

            return Column(
              children: [
                ExpansionTile(
                  leading: Icon(categoryIcon, color: colorScheme.primary),
                  title: Text(
                    category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  backgroundColor: Colors.grey[200],
                  collapsedBackgroundColor: Colors.grey[300],
                  children: wines.map((wine) {
                    return ListTile(
                      title: Text(
                        wine.replaceAll('_', ' ').toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      leading: const Icon(Icons.local_bar, color: Colors.grey),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WinePairingPage(wineName: wine),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}