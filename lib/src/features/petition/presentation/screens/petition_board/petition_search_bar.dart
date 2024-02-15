part of 'petition_board_screen.dart';

class PetitionSearchBar extends StatefulWidget {
  final FocusNode? focusNode;
  final void Function(String? keyword) onSearch;

  const PetitionSearchBar({
    super.key,
    this.focusNode,
    required this.onSearch,
  });

  @override
  State<StatefulWidget> createState() => _PetitionSearchBarState();
}

class _PetitionSearchBarState extends State<PetitionSearchBar> {
  late final TextEditingController keywordController;

  bool onSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keywordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.focusNode?.dispose();
    keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: keywordController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '검색',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: const Icon(
                Icons.search,
              ),
              filled: true,
              fillColor: themeData.colorScheme.surfaceVariant,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              counterText: '',
              suffixIcon: keywordController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          keywordController.clear();
                        });
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
            maxLines: 1,
            maxLength: 50,
            onChanged: (value) {
              setState(() {});
            },
            onFieldSubmitted: (value) async {
              setState(() {
                onSearch = true;
                widget.onSearch(value);
              });
            },
            onTapOutside: (pointerDownEvent) {
              widget.focusNode?.unfocus();
            },
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            width: onSearch ? null : 0,
            child: onSearch
                ? InkWell(
                    onTap: () {
                      setState(() {
                        onSearch = false;
                        keywordController.clear();
                        widget.onSearch(null);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '취소',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
