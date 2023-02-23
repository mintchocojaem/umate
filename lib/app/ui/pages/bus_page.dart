import 'package:flutter/material.dart';

class BusPage extends StatelessWidget {
  const BusPage({super.key});

  static const String _title = '버스 정보';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const _BusPage(),
      ),
    );
  }
}

class _BusPage extends StatelessWidget {
  const _BusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
