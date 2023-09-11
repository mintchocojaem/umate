import 'package:flutter/material.dart';

import '../../../modules/orb/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrbScaffold(
      orbAppBar: const OrbAppBar(
        title: "Danvery",
      ),
      body: Column(
        children: [
          OrbBoard(
            title: "ModernBoard",
            child: Column(
              children: [
                OrbTile(
                  title: "CompactTileeeeeeeeeeeeeeeeeee",
                  body: "bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyy",
                ),
                OrbTile(
                  title: "CompactTile",
                  body: "body",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const OrbBoard(
            title: "ModernBoard",
            child: Column(
              children: [
                OrbTile(
                  title: "CompactTile",
                  body: "body",
                ),
                OrbTile(
                  title: "CompactTile",
                  body: "body",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: OrbBottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
        ],
      ),
    );
  }
}
