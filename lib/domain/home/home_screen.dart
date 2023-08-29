import 'package:flutter/material.dart';

import '../../modules/orb/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      context: context,
      appBar: const ModernAppBar(
        title: "Danvery",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModernBoard(
              title: "ModernBoard",
              child: Column(
                children: [
                  CompactTile(
                    title: "CompactTile",
                    body: "body",
                  ),
                  CompactTile(
                    title: "CompactTile",
                    body: "body",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const ModernBoard(
              title: "ModernBoard",
              child: Column(
                children: [
                  CompactTile(
                    title: "CompactTile",
                    body: "body",
                  ),
                  CompactTile(
                    title: "CompactTile",
                    body: "body",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ModernBottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
        ],
      ),
    );
  }
}
