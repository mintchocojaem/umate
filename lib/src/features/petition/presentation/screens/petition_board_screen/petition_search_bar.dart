part of 'petition_board_screen.dart';

class PetitionSearchBar extends StatefulWidget {
  final TextEditingController keywordController;

  const PetitionSearchBar({
    super.key,
    required this.keywordController,
  });

  @override
  State<StatefulWidget> createState() => _PetitionSearchBarState();
}

class _PetitionSearchBarState extends State<PetitionSearchBar> {
  late final FocusNode focusNode;
  late final TextEditingController searchController;
  bool onSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    searchController = widget.keywordController;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    searchController.dispose();
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
            focusNode: focusNode,
            controller: searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '검색',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: Icon(
                Icons.search,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              counterText: '',
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.clear();
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
              });
            },
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            width: onSearch ? null : 0,
            child: onSearch
                ? InkWell(
                    onTap: () {
                      setState(() {
                        onSearch = false;
                        searchController.clear();
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
