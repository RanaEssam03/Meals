import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;
  @override
  void initState() {
    super.initState();
    final filters = ref.read(filtersProvider);
    _isGlutenFree = filters[Filter.glutenFree]!;
    _isLactoseFree = filters[Filter.lactoseFree]!;
    _isVegan = filters[Filter.vegan]!;
    _isVegetarian = filters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filtters"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            onChanged: (isChecked) {
              setState(
                () {
                  _isGlutenFree = isChecked;
                  ref
                      .read(filtersProvider.notifier)
                      .changeState(Filter.glutenFree, isChecked);
                },
              );
            },
            value: _isGlutenFree,
            title: Text(
              "Gluten-free",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only include gluten-free meals",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          SwitchListTile(
            onChanged: (isChecked) {
              setState(
                () {
                  _isLactoseFree = isChecked;
                  ref
                      .read(filtersProvider.notifier)
                      .changeState(Filter.lactoseFree, isChecked);
                },
              );
            },
            value: _isLactoseFree,
            title: Text(
              "Lactose-free",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only include lactose-free meals",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          SwitchListTile(
            onChanged: (isChecked) {
              setState(
                () {
                  _isVegetarian = isChecked;
                  ref
                      .read(filtersProvider.notifier)
                      .changeState(Filter.vegetarian, isChecked);
                },
              );
            },
            value: _isVegetarian,
            title: Text(
              "Vegetarian",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only include vegetarain meals",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          SwitchListTile(
            onChanged: (isChecked) {
              setState(
                () {
                  _isVegan = isChecked;
                  ref
                      .read(filtersProvider.notifier)
                      .changeState(Filter.vegan, isChecked);
                },
              );
            },
            value: _isVegan,
            title: Text(
              "Vegan",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              "Only include vegan meals",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ],
      ),
    );
  }
}
