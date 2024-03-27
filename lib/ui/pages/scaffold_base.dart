import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldBase extends StatefulWidget {
  const ScaffoldBase(this.navigationShell, {super.key});
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldBase> createState() => _ScaffoldBaseState();
}

class _ScaffoldBaseState extends State<ScaffoldBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tables'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
        onTap: _onTap,
      ),
    );
  }

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
