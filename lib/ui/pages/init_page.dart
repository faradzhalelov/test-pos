import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_order/db/db_helper.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    initDb();
  }

  initDb() async {
    await DatabaseHelper.database;
    if (context.mounted) {
      Future.delayed(
          const Duration(milliseconds: 300), () => context.go('/tables'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      )),
    );
  }
}
