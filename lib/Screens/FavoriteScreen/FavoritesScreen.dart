import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Providers/favoriteMealsProvider.dart';
import 'package:store_app/Screens/FavoriteScreen/favoriteService.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  late FavoriteService favoriteService;

  @override
  void initState() {
    super.initState();
    favoriteService = FavoriteService(ref: ref);
    final customer = ref.read(customerProviderr);
    favoriteService
      ..fullName = customer.fullName
      ..ID = customer.ID
      ..email = customer.email;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteAsync = ref.watch(favoriteStoresProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.deepPurple, // Tormettac-inspired
        elevation: 4,
      ),
      body: favoriteAsync.when(
        data:
            (stores) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: stores.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final store = stores[index];
                  return StoreCard(
                    store: store,
                    favoriteService: favoriteService,
                  );
                },
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Text('Error: $error', style: TextStyle(color: Colors.red)),
            ),
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final Store store;
  final FavoriteService favoriteService;

  const StoreCard({
    super.key,
    required this.store,
    required this.favoriteService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child:
                store.imageBytes != null
                    ? Image.memory(store.imageBytes!, fit: BoxFit.cover)
                    : const Icon(Icons.store, size: 100, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              store.name,

              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              store.description,
              style: TextStyle(color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 18),
                Text('${store.rating}', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ElevatedButton(
              onPressed: () {
                favoriteService.toggleFavorite(store);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Toggle Favorite'),
            ),
          ),
        ],
      ),
    );
  }
}
