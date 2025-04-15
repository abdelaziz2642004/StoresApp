// Function to fetch stores from the API
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/main.dart';
import 'package:http/http.dart' as http;

Future<List<Store>> fetchStores() async {
  final response = await http.get(Uri.parse('$baseUrl/getStores'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((storeData) {

      Uint8List? imageBytes = base64Decode(
        storeData['imageData'] == null
            ? ''
            : storeData['imageData']['imageData'] as String,
      );

      return Store(
        name: storeData['name'],
        description: storeData['description'],
        rating: storeData['rating'].toDouble(),
        latitude: storeData['latitude'].toDouble(),
        longitude: storeData['longitude'].toDouble(),
        imageBytes: imageBytes
      );
    }).toList();
  } else {
    throw Exception('Failed to load stores');
  }
}

// FutureProvider to fetch the list of stores
final storesProvider = FutureProvider<List<Store>>((ref) async {
  return fetchStores();
});
