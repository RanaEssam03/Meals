import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

enum Filters{
  glutenFree,
  lactoseFree,
  vegetarian,
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;

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
                },
              );
            },
            value: _isVegetarian,
            title: Text(
              "vegetarian",
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
        ],
      ),
    );
  }
}
