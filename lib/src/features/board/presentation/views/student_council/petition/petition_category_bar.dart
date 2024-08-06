part of 'petition_board_screen.dart';

class PetitionCategoryBar extends ConsumerWidget {
  final List<PetitionStatus> categoryList;
  final Function(int index)? onIndexChanged;

  const PetitionCategoryBar({
    super.key,
    required this.categoryList,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return CategoryBar(
      currentIndex: categoryList.indexOf(
          ref.watch(petitionCategoryControllerProvider)
      ),
      categoryList: [
        for (final category in categoryList) category.korean,
      ],
      onIndexChanged: (index) {
        ref.read(petitionCategoryControllerProvider.notifier).change(
              type: categoryList[index],
            );
        onIndexChanged?.call(index);
      },
    );
  }
}
