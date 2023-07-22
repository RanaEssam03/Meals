import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];

  int _selectedIndex = 0;
  late Map<Filter, bool> _selectedFilters;
  @override
  void initState() {
    _selectedFilters = kInitialFilters;

    super.initState();
  }

  void _selectTab(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(
      () {
        ScaffoldMessenger.of(context).clearSnackBars();
        if (isExisting) {
          _favoriteMeals.remove(meal);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Meal is no longer a favorite!"),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          _favoriteMeals.add(meal);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Marked as a favorite!"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) {
            return FiltersScreen(
              selectedFilters: _selectedFilters,
            );
          },
        ),
      );

      setState(
        () {
          _selectedFilters = result ?? kInitialFilters;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CategoriesScreen(
      filters: _selectedFilters,
      onToggleFavorite: _toggleFavorite,
    );
    String activePageTitle = "Categories";
    if (_selectedIndex == 1) {
      activePageTitle = "Your Favorites";
      content = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavorite,
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
