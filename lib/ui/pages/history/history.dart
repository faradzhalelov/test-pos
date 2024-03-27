import 'package:flutter/material.dart';
import 'package:pos_order/ui/components/drawer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    initHistory();
  }

  initHistory() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.green,
            child: Column(
              children: [Text('ИСТОРИЯ')],
            ),
          ),
        ),
      ),
    );
  }
}
