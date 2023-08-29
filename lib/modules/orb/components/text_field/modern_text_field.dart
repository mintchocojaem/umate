import 'package:flutter/material.dart';

class ModernTextField extends TextField {

  final String labelText;

  const ModernTextField({
    super.key,
    super.controller,
    super.obscureText,
    required this.labelText,
    super.keyboardType,
    super.textInputAction,
  });

  @override
  // TODO: implement decoration
  InputDecoration? get decoration => InputDecoration(
        labelText: labelText,
      );

  @override
  // TODO: implement autocorrect
  bool get autocorrect => false;

  @override
  // TODO: implement enableSuggestions
  bool get enableSuggestions => false;

}
