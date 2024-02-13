import 'package:flutter/material.dart';

class PetitionSearchBar extends StatefulWidget {
  final TextEditingController keywordController;
  final FocusNode? focusNode;

  const PetitionSearchBar({
    super.key,
    required this.keywordController,
    this.focusNode,
  });

  @override
  State<StatefulWidget> createState() => _PetitionSearchBarState();
}

class _PetitionSearchBarState extends State<PetitionSearchBar> {
  bool onSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.focusNode?.dispose();
    widget.keywordController.dispose();
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
            controller: widget.keywordController,
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
              suffixIcon: widget.keywordController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.keywordController.clear();
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
            onTapOutside: (pointerDownEvent) {
              widget.focusNode?.unfocus();
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
                        widget.keywordController.clear();
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
