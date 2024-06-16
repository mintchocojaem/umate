import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbSearchBar extends StatefulWidget {
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final void Function(String query)onTextChange;
  final void Function(String query) onSearch;
  final TextEditingController? textController;
  final Color? backgroundColor;

  const OrbSearchBar({
    super.key,
    this.focusNode,
    this.contentPadding,
    this.textStyle,
    required this.onTextChange,
    required this.onSearch,
    this.textController,
    this.backgroundColor,
  });

  @override
  State<StatefulWidget> createState() => _OrbSearchBarState();
}

class _OrbSearchBarState extends State<OrbSearchBar> {
  late final TextEditingController keywordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keywordController = widget.textController ?? TextEditingController();
  }

  bool onSearch = false;

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.textController == null) {
      keywordController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: keywordController,
            textInputAction: TextInputAction.search,
            style: widget.textStyle ?? themeData.textTheme.bodyMedium,
            cursorColor: palette.primary,
            cursorErrorColor: palette.error,
            decoration: InputDecoration(
              hintText: '검색',
              hintStyle: widget.textStyle ?? themeData.textTheme.bodyMedium,
              filled: true,
              fillColor: palette.surfaceBright,
              prefixIcon: const OrbIcon(
                Icons.search_rounded,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
              counterText: '',
              suffixIcon: keywordController.text.isNotEmpty
                  ? IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
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
              setState(() {
                widget.onTextChange(value);
              });
            },
            onFieldSubmitted: (value) async {
              setState(() {
                onSearch = true;
                widget.onSearch(value);
              });
            },
            onTapOutside: (pointerDownEvent) {
              //widget.focusNode?.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
