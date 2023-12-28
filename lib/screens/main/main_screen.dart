import 'package:danvery/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/orb/components/components.dart';

final pageControllerProvider = StateProvider<PageController>((ref) {
  return PageController(initialPage: 0);
});

final _currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: ref.watch(pageControllerProvider),
        onPageChanged: (value){
          ref.read(_currentIndexProvider.notifier).update((state) => value);
        },
        children: const[
          HomeScreen(),
          BoardScreen(),
          TimetableScreen(),
          ProfileScreen(),
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
          ref.read(pageControllerProvider).jumpToPage(value);
        },
        currentIndex: ref.watch(_currentIndexProvider),
      ),
    );
  }

}
