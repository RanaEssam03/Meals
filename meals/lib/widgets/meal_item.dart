import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget{
  const MealItem({required this.meal,super.key});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
   return Text(meal.title);
  }

}