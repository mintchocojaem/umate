import 'package:flutter/material.dart';

class OrbTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool readOnly;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final String? Function(String?)? validator;
  final InputBorder? border;
  final Widget? suffixIcon;

  const OrbTextFormField({
    super.key,
    this.controller,
    this.obscureText,
    this.labelText,
    this.hintText,
    this.helperText,
    this.keyboardType,
    this.textInputAction,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.maxLength,
    this.validator,
    this.border,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final ThemeData theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        counterText: "",
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        enabledBorder: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorScheme.surfaceVariant,
              ),
            ),
        suffixIcon: suffixIcon,
      ),
      style: theme.textTheme.bodyLarge?.copyWith(
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
    );
  }
}
