import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      required this.category,
      required this.name,
      required this.price,
      this.onTapPlus,
      this.onTapMinus});

  final String category;
  final String name;
  final double price;
  final void Function()? onTapPlus;
  final void Function()? onTapMinus;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$category: $name - $price руб.'),
        IconButton(
            onPressed: () => onTapPlus?.call(), icon: const Icon(Icons.add)),
        if (onTapMinus != null) ...[
          IconButton(
              onPressed: () => onTapMinus?.call(),
              icon: const Icon(Icons.remove))
        ]
      ],
    );
  }
}
