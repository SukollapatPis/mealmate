import 'package:flutter/material.dart';
import 'package:mealmate/api/recipe_api.dart';
import 'package:mealmate/models/recipe_model.dart';
import 'package:mealmate/pages/search_input_page.dart';
import 'package:mealmate/pages/wine_page.dart'; // นำเข้า WinePage
import 'package:mealmate/pages/restaurant_page.dart'; // นำเข้า RestaurantPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final recipeApi = RecipeApi();
  int _selectedIndex = 0; // เพิ่มตัวแปรเพื่อติดตาม index ที่ถูกเลือก

  List<RecipeModel> recipes = [];

  @override
  void initState() {
    recipeApi.searchRecipes("", "", "").then((value) {
      setState(() {
        recipes = value.results;
      });
    });
    super.initState();
  }

  void _openSearchPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchInputPage(),
      ),
    );

    if (result != null) {
      final searchText = result['searchText'];
      final cuisine = result['cuisine'];
      final dishType = result['dishType'];

      print("Search Text: $searchText");
      print("Cuisine: $cuisine");
      print("Dish Type: $dishType");

      recipeApi.searchRecipes(searchText, cuisine, dishType).then((value) {
        setState(() {
          recipes = value.results;
        });
      });
    }
  }

  // เพิ่มเมธอดเพื่อจัดการการเปลี่ยนหน้า
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // อยู่ที่หน้า Home อยู่แล้ว ไม่ต้องทำอะไร
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WinePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RestaurantPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _openSearchPage,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      enabled: false, // ปิดการใช้งาน TextField
                      decoration: InputDecoration(
                        hintText: 'Search of recipes name',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Recommend recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(recipes[index].image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), // Darken by 50%
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipes[index].title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Wine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurant',
          ),
        ],
        currentIndex: _selectedIndex, // ใช้ _selectedIndex เพื่อติดตามหน้าปัจจุบัน
        selectedItemColor: colorScheme.primary,
        onTap: _onItemTapped, // เรียกใช้เมธอด _onItemTapped เมื่อผู้ใช้แตะที่ไอคอน
      ),
    );
  }
}