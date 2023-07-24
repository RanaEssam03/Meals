import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super(
          {
            Filter.glutenFree: false,
            Filter.lactoseFree: false,
            Filter.vegetarian: false,
            Filter.vegan: false,
          },
        );

  void changeState(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  return meals.where((meal) {
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
  }).toList();
});
