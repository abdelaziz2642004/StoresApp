import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Screens/StoreDetailsScreen/StoreDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/app.dart';

const String baseUrl =
    "http://192.168.1.104:8080"; // if windows , ipconfig , and get your computer's ip and put it here
// and if ubuntu or linux , ip a , next to inet :D

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(CustomerAdapter()); // Register here
  await Hive.openBox('student'); // Open the authBox before using it

  runApp(const ProviderScope(child: MaterialApp(home: App())));
}
