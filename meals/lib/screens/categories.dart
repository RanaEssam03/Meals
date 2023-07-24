import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/filters.dart';

import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen(
      { super.key});



  bool _filterMeal(Meal meal, Map<Filter, bool>filters) {
    if (filters[Filter.glutenFree]!) {
      return meal.isGlutenFree;
    }
    if (filters[Filter.lactoseFree]!) {
      return meal.isLactoseFree;
    }
    if (filters[Filter.vegetarian]!) {
      return meal.isVegetarian;
    }
    if (filters[Filter.vegan]!) {
      return meal.isVegan;
    }
    return true;
  }

  void _selectCategory(
      BuildContext context, Category category, List<Meal> meals,  Map<Filter, bool>filters) {
    final filteredMeals = meals
        .where(
          (meal) => meal.categories.contains(category.id) && _filterMeal(meal, filters),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    final meals = ref.watch(mealsProvider);
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // for(final category in availableCategories)
        // CategoryGridItem(category: category)
        // OR
        ...availableCategories.map(
          (category) => CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category, meals, filters);
            },
          ),
        )
      ],
    );
  }
}
