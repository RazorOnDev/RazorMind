import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// The current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Shortcut for [ThemeData.colorScheme].
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Shortcut for [ThemeData.textTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// The logical size of the current screen.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Screen width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// The current [MediaQueryData].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Safe area padding insets.
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Bottom safe area inset (e.g. home indicator height on iOS).
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  /// Top safe area inset (e.g. status bar height).
  double get topPadding => MediaQuery.paddingOf(this).top;

  /// Whether the keyboard is currently visible.
  bool get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom > 0;

  /// Device pixel ratio.
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// Whether the screen width is considered a small/phone screen.
  bool get isSmallScreen => screenWidth < 600;

  /// Whether the screen width is considered a tablet or larger.
  bool get isTablet => screenWidth >= 600;

  /// Shows a [SnackBar] with the given [message].
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Hides any currently visible [SnackBar].
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  /// Unfocuses the current focus node (dismisses keyboard).
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}
