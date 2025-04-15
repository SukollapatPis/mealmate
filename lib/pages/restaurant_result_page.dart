import 'package:flutter/material.dart';
import 'package:mealmate/api/restaurant_api.dart';
import 'package:mealmate/models/restaurant_model.dart';
import 'package:mealmate/pages/restaurant_detail_page.dart'; // <- เพิ่ม import นี้

class RestaurantResultPage extends StatefulWidget {
  final String cuisine;
  final double lat;
  final double lng;

  const RestaurantResultPage({
    super.key,
    required this.cuisine,
    required this.lat,
    required this.lng,
  });

  @override
  State<RestaurantResultPage> createState() => _RestaurantResultPageState();
}

class _RestaurantResultPageState extends State<RestaurantResultPage> {
  late Future<List<Restaurant>> _restaurantFuture;

  @override
  void initState() {
    super.initState();
    _restaurantFuture = RestaurantApi().fetchRestaurants(
      cuisine: widget.cuisine,
      lat: widget.lat,
      lng: widget.lng,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 116, 109),
        title: Text('Restaurants - ${widget.cuisine}'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _restaurantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          }

          final restaurants = snapshot.data!;

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final r = restaurants[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(r.name),
                  subtitle: Text(r.address.city ?? 'Unknown Location'),
                  trailing: r.isOnlineDeliveryAvailable == true? const Icon(Icons.delivery_dining, color: Colors.green): const Icon(Icons.delivery_dining, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailPage(
                          restaurant: r.toJson(),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
