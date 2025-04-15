import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final address = restaurant['address'] ?? {};
    final cuisines = List<String>.from(restaurant['cuisines'] ?? []);
    final logoPhotos = List<String>.from(restaurant['logo_photos'] ?? []);
    final deliveryEnabled = restaurant['isOnlineDeliveryAvailable'] == true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 116, 109),
        title: Text(
          restaurant['name']?.toString() ?? 'Restaurant Detail',
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant['name']?.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                InfoRow(
                  label: "phone number",
                  value: (restaurant['phoneNumber'] ?? '').toString(),
                ),
                const SizedBox(height: 8),
                InfoRow(
                  label: "address",
                  value:
                      "street: ${address['street']?.toString() ?? ''}\n"
                      "city: ${address['city']?.toString() ?? ''}\n"
                      "zipcode: ${address['zipcode']?.toString() ?? ''}\n"
                      "country: ${address['country']?.toString() ?? ''}",
                ),
                const SizedBox(height: 8),
                InfoRow(
                  label: "type",
                  value: restaurant['type']?.toString() ?? 'restaurant',
                ),
                const SizedBox(height: 8),
                InfoRow(
                  label: "description",
                  value:restaurant['description']?.toString() ?? '',
                ),
                const SizedBox(height: 16),
                const Text(
                  "Online Delivery",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: deliveryEnabled ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    deliveryEnabled ? 'available' : 'unavailable',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                if (logoPhotos.isNotEmpty)
                  Center(
                    child: Image.network(
                      logoPhotos.first,
                      height: 60,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}
