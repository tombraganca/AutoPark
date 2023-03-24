import 'package:flutter/material.dart';

class ItemsDrawer extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const ItemsDrawer({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
              onPressed: () => onPressed(),
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
