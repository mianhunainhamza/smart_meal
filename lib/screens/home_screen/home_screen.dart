import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/screens/home_screen/components/categories.dart';
import 'package:smart_meal/screens/home_screen/components/explore_widget.dart';
import 'package:smart_meal/screens/home_screen/components/home_appbar.dart';
import 'package:smart_meal/screens/home_screen/components/home_search_bar.dart';
import 'package:smart_meal/screens/home_screen/components/quick_and_fast_list.dart';
import 'package:smart_meal/widgets/custom_floating_button.dart';

import '../../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentCat = "All";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton:cartProvider.ingredients.isNotEmpty || cartProvider.items.isNotEmpty
          ? CustomFloatingAction(cartProvider: cartProvider)
          : Container(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(height: 20),
                const HomeSearchBar(),
                const SizedBox(height: 20),
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const ExploreWidget(),
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Categories(currentCat: currentCat),
                const SizedBox(height: 20),
                const QuickAndFastList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
