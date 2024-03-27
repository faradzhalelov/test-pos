import 'package:flutter/material.dart';
import 'package:pos_order/models/table.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  late List<TableModel> tables;
  @override
  void initState() {
    super.initState();
  }

  initTablesFromDb() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Column(
          children: [
            Text('СТОЛЫ'),
          ],
        ));
  }
}
