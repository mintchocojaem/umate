part of 'petition_board_screen.dart';

class PetitionStatusBar extends StatefulWidget {
  const PetitionStatusBar({
    super.key,
    this.currentStatus,
    required this.statusList,
    required this.onStatusChanged,
  });

  final PetitionStatus? currentStatus;
  final List<PetitionStatus> statusList;
  final void Function(PetitionStatus status) onStatusChanged;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionStatusBarState();
  }
}

class _PetitionStatusBarState extends State<PetitionStatusBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.statusList
        .indexOf(widget.currentStatus ?? PetitionStatus.active);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < widget.statusList.length; i++)
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = i;
                });
                widget.onStatusChanged(widget.statusList[i]);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 16,
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedIndex == i
                      ? themeData.colorScheme.primary
                      : themeData.colorScheme.surface,
                ),
                child: Text(
                  widget.statusList[i].display,
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
      ),
    );
  }
}
