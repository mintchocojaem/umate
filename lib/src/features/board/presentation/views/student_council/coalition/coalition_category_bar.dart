part of 'coalition_board_screen.dart';

class CoalitionCategoryBar extends ConsumerWidget {
  final List<CoalitionType> categoryList;
  final Function(int index)? onIndexChanged;

  const CoalitionCategoryBar({
    super.key,
    required this.categoryList,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return CategoryBar(
      currentIndex: categoryList.indexOf(
        ref.watch(coalitionCategoryControllerProvider),
      ),
      categoryList: [
        for (final category in categoryList) category.displayName,
      ],
      onIndexChanged: (index) {
        ref.read(coalitionCategoryControllerProvider.notifier).change(
              type: categoryList[index],
            );
        onIndexChanged?.call(index);
      },
    );
  }
}
