class Restaurant {
  final String name;
  final int? phoneNumber;
  final String type;
  final String? description;
  final bool? isOnlineDeliveryAvailable;
  final RestaurantAddress address;

  Restaurant({
    required this.name,
    required this.type,
    required this.address,
    this.phoneNumber,
    this.description,
    this.isOnlineDeliveryAvailable,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'],
      type: json['type'] ?? '',
      description: json['description'],
      isOnlineDeliveryAvailable: json['delivery_enabled'],
      address: RestaurantAddress.fromJson(json['address'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'type': type,
      'description': description,
      'isOnlineDeliveryAvailable': isOnlineDeliveryAvailable,
      'address': address.toJson(),
    };
  }
}

class RestaurantAddress {
  final String? street;
  final String? city;
  final String? zipcode;
  final String? country;
  final double? latitude;
  final double? longitude;

  RestaurantAddress({
    this.street,
    this.city,
    this.zipcode,
    this.country,
    this.latitude,
    this.longitude,
  });

  factory RestaurantAddress.fromJson(Map<String, dynamic> json) {
    return RestaurantAddress(
      street: json['street_addr'],
      city: json['city'],
      zipcode: json['zipcode'],
      country: json['country'],
      latitude: (json['latitude'] is num) ? json['latitude'].toDouble() : null,
      longitude: (json['longitude'] is num) ? json['longitude'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'zipcode': zipcode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
