import 'package:flutter/material.dart';

import '../orb.dart';

class OrbSearchBarTheme {
  final Color backgroundColor;

  const OrbSearchBarTheme({
    required this.backgroundColor,
  });
}

class OrbContainerTheme {
  final Color backgroundColor;

  const OrbContainerTheme({
    required this.backgroundColor,
  });
}

class OrbTileTheme {
  final Color backgroundColor;

  const OrbTileTheme({
    required this.backgroundColor,
  });
}

class OrbTextFieldTheme {
  final Color boarderColor;
  final Color fillColor;
  final Color suffixIconColor;

  const OrbTextFieldTheme({
    required this.boarderColor,
    required this.fillColor,
    required this.suffixIconColor,
  });
}

class OrbSnackBarTheme {
  final Color backgroundColor;

  const OrbSnackBarTheme({
    required this.backgroundColor,
  });
}

class OrbShimmerTheme {
  final Color baseColor;
  final Color highlightColor;

  const OrbShimmerTheme({
    required this.baseColor,
    required this.highlightColor,
  });
}

class OrbBottomSheetTheme {
  final Color dragHolderColor;
  final Color backgroundColor;

  const OrbBottomSheetTheme({
    required this.dragHolderColor,
    required this.backgroundColor,
  });
}

class OrbBottomNavigationBarTheme {
  final Color backgroundColor;
  final Color borderColor;

  const OrbBottomNavigationBarTheme({
    required this.backgroundColor,
    required this.borderColor,
  });
}

class OrbTextButtonTheme {
  final Color textColor;

  const OrbTextButtonTheme({
    required this.textColor,
  });
}

class OrbFilledButtonTheme {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;

  const OrbFilledButtonTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledBackgroundColor,
    required this.disabledForegroundColor,
  });
}

class OrbAppbarTheme {
  final Color backgroundColor;
  final Color iconColor;
  final Color loadingBarBaseColor;
  final Color loadingBarHighlightColor;

  const OrbAppbarTheme({
    required this.backgroundColor,
    required this.iconColor,
    required this.loadingBarBaseColor,
    required this.loadingBarHighlightColor,
  });
}

class OrbDialogTheme {
  final Color backgroundColor;

  const OrbDialogTheme({
    required this.backgroundColor,
  });
}

class OrbScaffoldTheme {
  final Color backgroundColor;

  const OrbScaffoldTheme({
    required this.backgroundColor,
  });
}

class OrbTabBarTheme {
  final Color indicatorColor;

  const OrbTabBarTheme({
    required this.indicatorColor,
  });
}

class OrbDividerTheme {
  final Color color;

  const OrbDividerTheme({
    required this.color,
  });
}

class OrbThemeData {
  final OrbScaffoldTheme scaffoldTheme;
  final OrbAppbarTheme appbarTheme;
  final OrbFilledButtonTheme filledButtonTheme;
  final OrbTextButtonTheme textButtonTheme;
  final OrbBottomNavigationBarTheme bottomNavigationBarTheme;
  final OrbBottomSheetTheme bottomSheetTheme;
  final OrbShimmerTheme shimmerTheme;
  final OrbSnackBarTheme snackBarTheme;
  final OrbTextFieldTheme textFieldTheme;
  final OrbTileTheme tileTheme;
  final OrbDialogTheme dialogTheme;
  final OrbContainerTheme boardContainerTheme;
  final OrbSearchBarTheme searchBarTheme;
  final OrbTextTheme textTheme;
  final OrbTabBarTheme tabBarTheme;
  final OrbDividerTheme dividerTheme;

  const OrbThemeData({
    required this.scaffoldTheme,
    required this.appbarTheme,
    required this.filledButtonTheme,
    required this.textButtonTheme,
    required this.bottomNavigationBarTheme,
    required this.bottomSheetTheme,
    required this.shimmerTheme,
    required this.snackBarTheme,
    required this.textFieldTheme,
    required this.tileTheme,
    required this.dialogTheme,
    required this.boardContainerTheme,
    required this.searchBarTheme,
    required this.textTheme,
    required this.tabBarTheme,
    required this.dividerTheme,
  });

  factory OrbThemeData.light() {
    final palette = OrbLightPalette();
    return OrbThemeData(
      scaffoldTheme: OrbScaffoldTheme(
        backgroundColor: palette.background,
      ),
      appbarTheme: OrbAppbarTheme(
        backgroundColor: palette.background,
        iconColor: palette.surfaceDim,
        loadingBarBaseColor: palette.primary,
        loadingBarHighlightColor: palette.surface,
      ),
      filledButtonTheme: OrbFilledButtonTheme(
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        disabledBackgroundColor: palette.outline,
        disabledForegroundColor: palette.surface,
      ),
      textButtonTheme: OrbTextButtonTheme(
        textColor: palette.secondary,
      ),
      bottomNavigationBarTheme: OrbBottomNavigationBarTheme(
        backgroundColor: palette.background,
        borderColor: palette.outline,
      ),
      bottomSheetTheme: OrbBottomSheetTheme(
        dragHolderColor: palette.surfaceDim,
        backgroundColor: palette.background,
      ),
      shimmerTheme: OrbShimmerTheme(
        baseColor: palette.outline,
        highlightColor: palette.surfaceBright,
      ),
      snackBarTheme: OrbSnackBarTheme(
        backgroundColor: palette.surfaceBright,
      ),
      textFieldTheme: OrbTextFieldTheme(
        boarderColor: palette.surfaceBright,
        fillColor: palette.surfaceBright,
        suffixIconColor: palette.surfaceDim,
      ),
      tileTheme: OrbTileTheme(
        backgroundColor: palette.surfaceBright,
      ),
      dialogTheme: OrbDialogTheme(
        backgroundColor: palette.background,
      ),
      boardContainerTheme: OrbContainerTheme(
        backgroundColor: palette.surfaceBright,
      ),
      textTheme: OrbDefaultTextTheme(),
      searchBarTheme: OrbSearchBarTheme(
        backgroundColor: palette.surfaceBright,
      ),
      tabBarTheme: OrbTabBarTheme(
        indicatorColor: palette.primary,
      ),
      dividerTheme: OrbDividerTheme(
        color: palette.outline,
      ),
    );
  }

  static Brightness getBrightness(BuildContext context) {
    return Theme.of(context).brightness;
  }

  bool isLightMode(BuildContext context) {
    return getBrightness(context) == Brightness.light;
  }

  OrbPalette getCurrentPalette(BuildContext context) {
    return isLightMode(context) ? OrbLightPalette() : OrbDarkPalette();
  }
}

class OrbTheme extends StatelessWidget {
  final Widget child;

  const OrbTheme({
    super.key,
    required this.child,
  });

  static OrbThemeData of(BuildContext context) {
    final isLightMode = OrbThemeData.getBrightness(context) == Brightness.light;
    return isLightMode ? OrbThemeData.light() : OrbThemeData.light();
  }

  @override
  Widget build(BuildContext context) {
    final theme = OrbTheme.of(context);
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            highlightColor: Colors.transparent,
          ),
        ),
        tabBarTheme: TabBarTheme(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelStyle: theme.textTheme.bodyMedium,
          unselectedLabelStyle: theme.textTheme.bodyMedium,
        ),
      ),
      child: child,
    );
  }
}
