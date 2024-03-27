import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            TextButton(
                onPressed: () => context.go('/tables'),
                child: const Text('СТОЛЫ')),
            TextButton(
                onPressed: () => context.go('/history'),
                child: const Text('ИСТОРИЯ'))
          ],
        ),
      ),
    );
  }
}
