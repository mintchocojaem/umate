import 'package:danvery/src/design_system/orb/orb.dart';
import 'package:flutter/material.dart';

part 'model_widget.dart';

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

  final submitButton = OrbButton(
    buttonText: "Show OrbSnackBar",
    onPressed: () async {
      await Future.delayed(const Duration(seconds: 1), () {
        /*
        OrbService.showSnackBar(
          message: "OrbSnackBar",
          type: OrbSnackBarType.info,
        );*/
      });
    },
  );

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrbScaffold(
      scrollBody: false,
      orbAppBar: const OrbAppBar(
        title: "Home",
        showLoadingIndicator: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ModelWidget(
              title: 'OrbBoardContainer',
              child: OrbBoardContainer(
                child: Column(
                  children: [
                    const ModelWidget(
                      title: 'OrbTextField',
                      child: OrbTextFormField(
                        labelText: "Label",
                        hintText: "Hint",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ModelWidget(
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
                    ModelWidget(
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
                    ModelWidget(
                      title: 'OrbModalBottomSheet',
                      child: OrbButton(
                        buttonSize: OrbButtonSize.fit,
                        buttonText: "Show ModalBottomSheet",
                        onPressed: () async {
                          await const OrbModalBottomSheet(
                            titleText: "Title",
                            child: Text("Content"),
                          ).show(context);
                        },
                      ),
                    ),
                    ModelWidget(
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
                    const ModelWidget(
                      title: 'OrbShimmerContent',
                      child: OrbShimmerContent(),
                    ),
                    const ModelWidget(
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
            const ModelWidget(
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
            const ModelWidget(
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
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton.copyWith(
        buttonRadius: OrbButtonRadius.none,
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
