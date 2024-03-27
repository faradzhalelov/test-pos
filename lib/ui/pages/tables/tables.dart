import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_order/db/db_helper.dart';
import 'package:pos_order/db/db_service.dart';
import 'package:pos_order/models/table.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  List<TableModel> tables = [];
  @override
  void initState() {
    super.initState();
    initTablesFromDb();
  }

  initTablesFromDb() async {
    await DatabaseHelper.instanse.addData();
    final data = await DatabaseService().getTables();
    tables = data.map((m) => TableModel.fromDB(m)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const Text('СТОЛЫ:'),
            Expanded(
              child: ListView.builder(
                  itemCount: tables.length,
                  itemBuilder: (context, index) {
                    final tableData = tables[index];
                    final tableName = tableData.name;
                    final tableId = tableData.id;
                    final text = tableName ?? 'TABLE $tableId';
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Image.network(
                            'https://img.freepik.com/premium-psd/scene-creator-top-view-table-and-chairs-transparent-background_92267-916.jpg',
                            width: 50,
                            height: 50,
                          ),
                          TextButton(
                              onPressed: () {
                                context.go('/tables/$tableId');
                              },
                              child: Text(text)),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
