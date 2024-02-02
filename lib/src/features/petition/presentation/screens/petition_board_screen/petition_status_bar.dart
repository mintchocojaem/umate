part of 'petition_board_screen.dart';

class PetitionStatusBar extends StatelessWidget {

  final PetitionStatus currentStatus;
  final List<PetitionStatus> statusList;
  final void Function(PetitionStatus status) onStatusChanged;

  const PetitionStatusBar({
    super.key,
    required this.currentStatus,
    required this.statusList,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final selectedIndex = statusList.indexOf(currentStatus);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < statusList.length; i++)
          InkWell(
            onTap: () {
             onStatusChanged(statusList[i]);
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedIndex == i
                    ? themeData.colorScheme.primary
                    : themeData.colorScheme.surface,
              ),
              child: Text(
                statusList[i].display,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: selectedIndex == i
                      ? themeData.colorScheme.onPrimary
                      : themeData.colorScheme.onSurface,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
