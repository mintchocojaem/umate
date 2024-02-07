part of 'app_router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      physics: const NeverScrollableScrollPhysics(),
      routes: const [
        HomeRoute(),
        PetitionBoardRoute(),
      ],
      builder: (context, child, animation) {
        final themeData = Theme.of(context);
        return Scaffold(
          body: SafeArea(
            child: child,
          ),
          bottomNavigationBar: OrbBottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onIndexChanged: (index) {
              context.tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment), label: "게시판"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.space_dashboard), label: "시간표"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
            ],
          ),
        );
      },
    );
  }
}