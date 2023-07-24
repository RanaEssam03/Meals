import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _selectTab(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectScreen(String identifier) {
    Navigator.of(context).pop();

    if (identifier == 'Filters') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const CategoriesScreen();
    String activePageTitle = "Categories";
    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoritesProvider);
      activePageTitle = "Your Favorites";
      content = MealsScreen(
        meals: favoriteMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectTab,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites")
          ]),
    );
  }
}
