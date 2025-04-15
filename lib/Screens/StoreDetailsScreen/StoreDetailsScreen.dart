import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Screens/StoreDetailsScreen/distanceService.dart';

class StoreDetailsScreen extends ConsumerStatefulWidget {
  StoreDetailsScreen({super.key});

  @override
  ConsumerState<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends ConsumerState<StoreDetailsScreen> {
  final DistanceService distanceService = DistanceService();

  @override
  Widget build(BuildContext context) {
    final store = Store(
      name: 'Super Store',
      description: 'All-in-one shopping.',
      rating: 4.9,
      latitude: 30.0444,
      longitude: 31.2357,
      imageBytes: null,
    );

    final Future<double> distance = distanceService.getDistanceToStore(store);

    return FutureBuilder<double>(
      future: distance,
      builder: (context, snapshot) {
        String appBarTitle;
        if (snapshot.connectionState == ConnectionState.waiting) {
          appBarTitle = 'Loading...';
        } else if (snapshot.hasError) {
          appBarTitle = 'Error loading distance';
        } else {
          appBarTitle = 'Distance: ${snapshot.data?.toStringAsFixed(2)} m';
        }

        return Scaffold(
          appBar: AppBar(title: Text(appBarTitle)),
          body: Center(child: Text(store.description)),
        );
      },
    );
  }
}
