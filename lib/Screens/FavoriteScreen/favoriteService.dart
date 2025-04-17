import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/FieldsData/Service.dart';
import 'package:store_app/Models/store.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/Providers/favoriteMealsProvider.dart';
import 'package:store_app/main.dart';

class FavoriteService extends Service {
  final WidgetRef ref;
  FavoriteService({required this.ref});

  static Future<List<Store>> fetchFavoritedStores(int custID) async {
    final response = await http.get(Uri.parse('$baseUrl/$custID/getFavorites'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((storeData) {
        Uint8List? imageBytes = base64Decode(
          storeData['imageData'] == null
              ? ''
              : storeData['imageData']['imageData'] as String,
        );

        return Store(
          id: storeData['id'],
          name: storeData['name'],
          description: storeData['description'],
          rating: storeData['rating'].toDouble(),
          latitude: storeData['latitude'].toDouble(),
          longitude: storeData['longitude'].toDouble(),
          imageBytes: imageBytes,
        );
      }).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }

  Future<void> toggleFavorite(Store store) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$ID/toggleFavorite'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'store_id': store.id}),
    );

    if (response.statusCode != 200) {
      ref.invalidate(favoriteStoresProvider);
    }
  }
}
