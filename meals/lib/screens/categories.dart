import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesStateScreen();
}

class _CategoriesStateScreen extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
        lowerBound: 0,
        upperBound: 1);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final filteredMeals = ref.watch(filteredMealsProvider);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext ctx, Widget? child) => Padding(
        padding: EdgeInsets.only(
          top: 100 - _animationController.value * 100,
        ),
        child: child,
      ),
      child: GridView(
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
      ),
    );
  }
}
