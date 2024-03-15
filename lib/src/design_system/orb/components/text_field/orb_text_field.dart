import 'package:flutter/material.dart';

class OrbTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool obscureText;
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
    this.obscureText = false,
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
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrbTextFormFieldState();
  }
}

class _OrbTextFormFieldState extends State<OrbTextFormField> {
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

    final ThemeData theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      onTap: widget.onTap,
      decoration: InputDecoration(
        counterText: "",
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: widget.focusedBoarderColor ?? theme.colorScheme.primary,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.enabledBoarderColor ?? theme.colorScheme.surfaceVariant,
          ),
        ),
        suffixIcon: widget.obscureText
            ? InkWell(
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: theme.colorScheme.secondary,
                ),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                })
            : widget.suffixIcon,
      ),
      style: widget.inputTextStyle ??
          theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      validator: widget.validator,
      maxLines: widget.maxLines,
    );
  }
}
