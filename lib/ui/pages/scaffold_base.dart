import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_order/ui/components/drawer.dart';

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
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('APP'),
      ),
      body: widget.navigationShell,
    );
  }
}
