import 'package:flutter/material.dart';

class OrbTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final TextStyle? inputTextStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool readOnly;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final Color? enabledBoarderColor;
  final Color? focusedBoarderColor;

  const OrbTextFormField({
    super.key,
    this.controller,
    this.obscureText,
    this.labelText,
    this.hintText,
    this.helperText,
    this.inputTextStyle,
    this.keyboardType,
    this.textInputAction,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.suffixIcon,
    this.onTap,
    this.enabledBoarderColor,
    this.focusedBoarderColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final ThemeData theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      onTap: onTap,
      decoration: InputDecoration(
        counterText: "",
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: focusedBoarderColor ?? theme.colorScheme.primary,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: enabledBoarderColor ?? theme.colorScheme.surfaceVariant,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      style: inputTextStyle ?? theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLength: maxLength,
      validator: validator,
      maxLines: maxLines,
    );
  }
}
