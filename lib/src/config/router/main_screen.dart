import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/modules.dart';

final _currentIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final pageController = PageController(initialPage: 0);

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.yellow),
        ],
      ),
      bottomNavigationBar: OrbBottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "게시판"),
          BottomNavigationBarItem(
              icon: Icon(Icons.space_dashboard), label: "시간표"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
        ],
        onIndexChanged: (value) {
          ref.read(_currentIndexProvider.notifier).update((state) => value);
          pageController.jumpToPage(
            value,
          );
        },
        currentIndex: ref.watch(_currentIndexProvider),
      ),
    );
  }
}
