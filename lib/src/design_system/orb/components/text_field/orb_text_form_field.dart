import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool readOnly;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final Color? fillColor;
  final Color? boarderColor;
  final OrbTextType? style;

  const OrbTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.hintText,
    this.helperText,
    this.keyboardType,
    this.textInputAction,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.readOnly = false,
    this.autofocus = false,
    this.onSubmitted,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.suffixIcon,
    this.focusNode,
    this.onTap,
    this.fillColor,
    this.boarderColor,
    this.style = OrbTextType.bodyMedium,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrbTextFieldState();
  }
}

class _OrbTextFieldState extends State<OrbTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      onTap: widget.onTap,
      style: switch (widget.style) {
        OrbTextType.titleLarge => theme.textTheme.titleLarge,
        OrbTextType.titleMedium => theme.textTheme.titleMedium,
        OrbTextType.titleSmall => theme.textTheme.titleSmall,
        OrbTextType.bodyLarge => theme.textTheme.bodyLarge,
        OrbTextType.bodyMedium => theme.textTheme.bodyMedium,
        OrbTextType.bodySmall => theme.textTheme.bodySmall,
        _ => theme.textTheme.bodyMedium,
      },
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      validator: widget.validator,
      maxLines: widget.maxLines,
      cursorColor: theme.textFieldTheme.suffixIconColor,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.hintText,
        helperText: widget.helperText,
        helperStyle: theme.textTheme.bodySmall,
        hintMaxLines: 10,
        hintStyle: switch (widget.style) {
          OrbTextType.titleLarge => theme.textTheme.titleLarge,
          OrbTextType.titleMedium => theme.textTheme.titleMedium,
          OrbTextType.titleSmall => theme.textTheme.titleSmall,
          OrbTextType.bodyLarge => theme.textTheme.bodyLarge,
          OrbTextType.bodyMedium => theme.textTheme.bodyMedium,
          OrbTextType.bodySmall => theme.textTheme.bodySmall,
          _ => theme.textTheme.bodyMedium,
        },
        errorStyle: theme.textTheme.bodySmall.copyWith(
          color: currentPalette.error,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: currentPalette.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: currentPalette.error,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: widget.fillColor ?? theme.textFieldTheme.fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.boarderColor ?? theme.textFieldTheme.boarderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.boarderColor ?? theme.textFieldTheme.boarderColor,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIcon: widget.obscureText
            ? InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OrbIcon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: theme.textFieldTheme.suffixIconColor,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
      ),
    );
  }
}
