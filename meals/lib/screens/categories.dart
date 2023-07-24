import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(
      BuildContext context, Category category, List<Meal> meals) {
    final filteredMeals = meals
        .where(
          (meal) => meal.categories.contains(category.id),
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
    final filteredMeals = ref.watch(filteredMealsProvider);
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
              _selectCategory(context, category, filteredMeals);
            },
          ),
        )
      ],
    );
  }
}
