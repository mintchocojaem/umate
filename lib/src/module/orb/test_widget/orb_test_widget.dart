import 'package:danvery/src/module/orb/test_widget/test_widget.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class OrbTestWidget extends StatefulWidget {
  final VoidCallback onPressLightTheme;
  final VoidCallback onPressDarkTheme;

  const OrbTestWidget({
    super.key,
    required this.onPressLightTheme,
    required this.onPressDarkTheme,
  });

  @override
  createState() => _OrbTestWidgetState();
}

class _OrbTestWidgetState extends State<OrbTestWidget> {
  int _selectedIndex = 0;
  final FoldableScrollController _foldableScrollController =
      FoldableScrollController(
    scrollController: ScrollController(),
    height: 100,
    maxHeight: 100,
  );

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      scrollBody: false,
      orbAppBar: const OrbAppBar(
        title: "Home",
        showLoadingIndicator: true,
      ),
      body: SingleChildScrollView(
        controller: _foldableScrollController.scrollController,
        child: Column(
          children: [
            TestWidget(
              title: 'OrbFoldableContainer',
              child: OrbFoldableContainer(
                scrollController: _foldableScrollController,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 100,
                  child: const Center(
                    child: Text("Child"),
                  ),
                ),
              ),
            ),
            TestWidget(
              title: 'OrbBoardContainer',
              child: OrbBoardContainer(
                child: Column(
                  children: [
                    const TestWidget(
                      title: 'OrbTextField',
                      child: OrbTextFormField(
                        labelText: "Label",
                        hintText: "Hint",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TestWidget(
                      title: 'OrbButton',
                      child: Column(
                        children: [
                          OrbButton(
                            buttonText: "Enabled",
                            onPressed: () {
                              //
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          OrbButton(
                            buttonText: "Disabled",
                            disabled: true,
                            onPressed: () {
                              //
                            },
                          ),
                        ],
                      ),
                    ),
                    TestWidget(
                      title: 'OrbBottomSheet',
                      child: OrbButton(
                        buttonSize: OrbButtonSize.compact,
                        buttonText: "Show BottomSheet",
                        onPressed: () async {
                          await OrbBottomSheet(
                            items: [
                              SheetItem(
                                  title: "Item 1", onPressed: () async {}),
                              SheetItem(
                                  title: "Item 2", onPressed: () async {}),
                            ],
                          ).show(context);
                        },
                      ),
                    ),
                    TestWidget(
                      title: 'OrbModalBottomSheet',
                      child: OrbButton(
                        buttonSize: OrbButtonSize.normal,
                        buttonText: "Show ModalBottomSheet",
                        onPressed: () async {
                          await const OrbModalBottomSheet(
                            titleText: "Title",
                            child: Text("Content"),
                          ).show(context);
                        },
                      ),
                    ),
                    TestWidget(
                      title: 'OrbDialog',
                      child: OrbButton(
                        buttonText: "Show Dialog",
                        onPressed: () async {
                          await OrbDialog(
                            title: "Dialog",
                            content: const Text("Content"),
                            rightButtonText: "RightButtonText",
                            leftButtonText: "LeftButtonText",
                            onRightButtonPressed: () async {
                              return true;
                            },
                            onLeftButtonPressed: () async {
                              return true;
                            },
                          ).show(context);
                        },
                      ),
                    ),
                    const TestWidget(
                      title: 'OrbShimmerContent',
                      child: OrbShimmerContent(),
                    ),
                    const TestWidget(
                      title: 'OrbListTile',
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            OrbListTile(
                              titleText: "Title1",
                              contentText: "Content1",
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            OrbListTile(
                              titleText: "Title2",
                              contentText: "Content2",
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            OrbListTile(
                              titleText: "Title3",
                              contentText: "Content3",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const TestWidget(
              title: 'OrbListCardTile',
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    OrbListCardTile(
                      titleText: "Title1",
                      contentText: "Content1",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    OrbListCardTile(
                      titleText: "Title2",
                      contentText: "Content2",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    OrbListCardTile(
                      titleText: "Title3",
                      contentText: "Content3",
                    ),
                  ],
                ),
              ),
            ),
            const TestWidget(
              title: 'OrbCardTile',
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OrbCardTile(
                      titleText: "Title1",
                      contentText: "Content1",
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    OrbCardTile(
                      titleText: "Title2",
                      contentText: "Content2",
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    OrbCardTile(
                      titleText: "Title3",
                      contentText: "Content3",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        buttonText: "Show OrbSnackBar",
        onPressed: () async {
          await Future.delayed(const Duration(seconds: 1), () {
            OrbSnackBar.show(
              message: "OrbSnackBar",
              type: OrbSnackBarType.info,
            );
          });
        },
      ),
      bottomNavigationBar: OrbBottomNavigationBar(
        currentIndex: _selectedIndex,
        onIndexChanged: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              widget.onPressLightTheme();
            } else {
              widget.onPressDarkTheme();
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.light_mode),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dark_mode),
            label: "Home",
          ),
        ],
      ),
    );
  }
}
