import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    required this.labal,
    required this.icon,
    super.key,
  });

  final String labal;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 3),
        Text(
          labal,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
