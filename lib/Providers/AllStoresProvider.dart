// Function to fetch stores from the API
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Screens/StoresScreen/StoreService.dart';

// FutureProvider to fetch the list of stores
final storesProvider = FutureProvider<List<Store>>((ref) async {
  return StoreService.fetchStores();
});
