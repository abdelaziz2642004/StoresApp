import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Providers/AllStoresProvider.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_colors.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/StoreCard.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/Store_app_bar.dart';


class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {


  @override
  Widget build(BuildContext context) {
    final storesAsyncValue = ref.watch(storesProvider);
    final Customer cust = ref.watch(customerProviderr); // so when image changes we listen to that change :D

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            StoreAppBar(primaryColor: primaryColor, customer: cust),
            storesAsyncValue.when(
              data: (stores) => SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final store = stores[index];
                    return StoreCard(
                      store: store,
                      cardColor: cardColor,
                      textColor: textColor,
                      secondaryText: secondaryText,
                      darkAccent: darkAccent,
                    );
                  },
                  childCount: stores.length,
                ),
              ),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator(color: Color(0xffc47c51))),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: darkAccent, size: 48),
                      const SizedBox(height: 16),
                      Text('Failed to load stores', style: TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(error.toString(), style: TextStyle(color: secondaryText), textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () => ref.refresh(storesProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
