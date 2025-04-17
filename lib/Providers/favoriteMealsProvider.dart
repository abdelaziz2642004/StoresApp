import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Screens/FavoriteScreen/favoriteService.dart';

// FutureProvider to fetch the list of stores
final favoriteStoresProvider = FutureProvider<List<Store>>((ref) async {
  final customer = ref.read(customerProviderr);
  return FavoriteService.fetchFavoritedStores(customer.ID);
});
