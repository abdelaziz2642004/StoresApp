import 'dart:typed_data';

class Store {
  final String name;
  final String description;
  final double rating;
  final double latitude;
  final double longitude;
  final Uint8List? imageBytes;

  Store({
    required this.name,
    required this.description,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.imageBytes,
  });
}
