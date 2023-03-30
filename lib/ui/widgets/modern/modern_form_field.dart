import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../utils/theme/app_text_theme.dart';
import '../../../utils/theme/palette.dart';

class ModernFormField extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextStyle? hintStyle;
  final String? initText;
  final String? initValidateText;
  final bool checkButton;
  final bool validate;
  final String? validateHint;
  final String? checkButtonText;
  final bool readOnly;
  final bool isPassword;
  final bool isSMS;
  final bool Function()? onCheckButtonPressed;
  final void Function(String text)? onTextChanged;
  final void Function(String text)? onValidateChanged;
  final int checkButtonCoolDown;
  final Color? titleColor;
  final TextInputType? keyboardType;
  final Icon? suffixIcon;

  const ModernFormField({
    super.key,
    this.hint,
    this.hintStyle,
    this.title,
    this.checkButton = false,
    this.validate = false,
    this.validateHint,
    this.checkButtonText,
    this.readOnly = false,
    this.isPassword = false,
    this.isSMS = false,
    this.onCheckButtonPressed,
    this.checkButtonCoolDown = 30,
    this.titleColor,
    this.keyboardType,
    this.onTextChanged,
    this.onValidateChanged,
    this.suffixIcon,
    this.initText,
    this.initValidateText,
  });

  @override
  createState() => _ModernFormField();
}

class _ModernFormField extends State<ModernFormField> {
  late int _remainingTime;
  final FocusNode focusSMS = FocusNode();
  bool _isSend = false;
  Timer? timer;

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _validateController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.checkButtonCoolDown;
    _textController.text = widget.initText ?? "";
    _validateController.text = widget.initValidateText ?? "";
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    timer?.cancel();
    super.dispose();
  }

  void _coolDown() {
    setState(() {
      _isSend = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        if (_remainingTime == 0) {
          timer.cancel();
          _isSend = false;
          _remainingTime = widget.checkButtonCoolDown;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title == null
            ? const SizedBox()
            : Text(
                widget.title!,
                style: titleStyle.copyWith(
                    color: widget.titleColor ?? Palette.grey,
                    fontWeight: FontWeight.w500),
              ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _textController,
          obscureText: widget.isPassword,
          enableSuggestions: false,
          autocorrect: false,
          enabled: !widget.readOnly,
          readOnly: widget.readOnly,
          onChanged: (text){
            widget.onTextChanged?.call(text);
          },
          keyboardType: widget.keyboardType,
          maxLines: 1,
          maxLength: 30,
          style: regularStyle.copyWith(color: Palette.lightBlack),
          cursorColor: widget.titleColor ?? Palette.blue,
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: Palette.darkWhite,
            border: const OutlineInputBorder(),
            hintText: widget.hint,
            hintStyle: widget.hintStyle ?? regularStyle.copyWith(
                color: widget.readOnly ? Palette.lightBlack : Palette.grey),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Palette.darkWhite,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 16,
            ),
            suffixIcon: widget.suffixIcon != null
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: widget.suffixIcon!,
                    onPressed: () {},
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: widget.titleColor ?? Palette.blue,
                width: 2.0,
              ),
            ),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 24, maxWidth: 32, minWidth: 24),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Palette.darkWhite,
                width: 1.0,
              ),
            ),
          ),
        ),
        widget.validate
            ? Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: widget.isSMS
                            ? TextFieldPinAutoFill(
                                currentCode: _smsController.text,
                                focusNode: focusSMS,
                                style: TextStyle(
                                    color: Palette.lightBlack),
                                codeLength: 6,
                                autoFocus: false,
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Palette.darkWhite,
                                  border: const OutlineInputBorder(),
                                  hintText: widget.validateHint ?? widget.hint,
                                  hintStyle: regularStyle.copyWith(
                                      color: Palette.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Palette.darkWhite,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                onCodeChanged: (code) {
                                  _smsController.text = code;
                                  widget.onValidateChanged?.call(code);
                                  if (code.length == 6) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              )
                            : TextFormField(
                                controller: _validateController,
                                style: TextStyle(
                                    color: Palette.lightBlack),
                                keyboardType: widget.keyboardType,
                                obscureText: widget.isPassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                onChanged: (text){
                                  widget.onValidateChanged?.call(text);
                                },
                                readOnly: widget.readOnly,
                                maxLines: 1,
                                maxLength: 30,
                                decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  filled: true,
                                  fillColor: Palette.darkWhite,
                                  border: const OutlineInputBorder(),
                                  hintText: widget.validateHint ?? widget.hint,
                                  hintStyle: regularStyle.copyWith(
                                      color: Palette.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Palette.darkWhite,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    widget.checkButton
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                                height: 48,
                                width: 100,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (!_isSend) {
                                      await SmsAutoFill().listenForCode();
                                      focusSMS.requestFocus();
                                      bool success =
                                          widget.onCheckButtonPressed?.call() ??
                                              false;
                                      if (success) _coolDown();
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: !_isSend
                                              ? Palette.blue
                                              : Palette.lightGrey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: !_isSend
                                          ? Palette.blue
                                          : Palette.lightGrey),
                                  child: Center(
                                    child: Text(
                                      _isSend
                                          ? "$_remainingTime"
                                          : "${widget.checkButtonText}",
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: !_isSend
                                              ? Palette.pureWhite
                                              : Palette.grey),
                                    ),
                                  ),
                                )),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
