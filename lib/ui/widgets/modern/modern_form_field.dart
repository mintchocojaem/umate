import 'dart:async';
import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/theme/app_text_theme.dart';

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
  final Widget? suffix;
  final double? suffixWidth;
  final String? validateHelperText;
  final String? helperText;
  final TextEditingController? controller;
  final bool isTime;

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
    this.suffix,
    this.initText,
    this.initValidateText,
    this.validateHelperText,
    this.helperText,
    this.suffixWidth,
    this.controller,
    this.isTime = false,
  });

  @override
  createState() => _ModernFormField();
}

class _ModernFormField extends State<ModernFormField> {
  late int _remainingTime;
  final FocusNode focusSMS = FocusNode();
  bool _isSend = false;
  Timer? timer;
  bool _isTextVisible = true;

  late final TextEditingController _textController;
  final TextEditingController _validateController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();

    _remainingTime = widget.checkButtonCoolDown;
    _textController.text = widget.initText ?? "";
    _validateController.text = widget.initValidateText ?? "";
    _isTextVisible = !widget.isPassword;

    _textController.addListener(() {
      widget.onTextChanged?.call(_textController.text);
    });
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
                style: smallTitleStyle.copyWith(
                    color: widget.titleColor ?? Palette.grey,
                    fontWeight: FontWeight.w500),
              ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onTap: widget.isTime
                  ? showTimePickerDialog : null,
              controller: _textController,
              obscureText: !_isTextVisible,
              enableSuggestions: false,
              autocorrect: false,
              enabled: !widget.readOnly,
              readOnly: widget.readOnly || widget.isTime,
              keyboardType: widget.keyboardType,
              maxLines: 1,
              maxLength: 30,
              style: regularStyle.copyWith(color: Palette.lightBlack),
              cursorColor: widget.titleColor ?? Palette.blue,
              decoration: InputDecoration(
                helperStyle: regularStyle.copyWith(color: Palette.grey),
                counterText: "",
                filled: true,
                fillColor: Palette.darkWhite,
                border: const OutlineInputBorder(),
                hintText: widget.hint,
                hintStyle: widget.hintStyle ??
                    regularStyle.copyWith(
                        color: widget.readOnly
                            ? Palette.lightBlack
                            : Palette.grey),
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
                suffixIcon: widget.isPassword
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            _isTextVisible
                                ? "assets/icons/login/visible_icon.png"
                                : "assets/icons/login/invisible_icon.png",
                            width: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isTextVisible = !_isTextVisible;
                            });
                          },
                        ),
                      )
                    : InkWell(
                        onTap: widget.isTime
                            ? showTimePickerDialog : null,
                        child: widget.suffix),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: widget.titleColor ?? Palette.blue,
                    width: 2.0,
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                    maxHeight: 24,
                    maxWidth: widget.suffixWidth ?? 60,
                    minWidth: 24,
                    minHeight: 24),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Palette.darkWhite,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            widget.helperText != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.helperText!,
                      style: lightStyle.copyWith(
                          color: Palette.blue),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        widget.validate
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: widget.isSMS
                                ? TextFieldPinAutoFill(
                                    currentCode: _smsController.text,
                                    focusNode: focusSMS,
                                    style: TextStyle(color: Palette.lightBlack),
                                    codeLength: 6,
                                    autoFocus: false,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      filled: true,
                                      fillColor: Palette.darkWhite,
                                      border: const OutlineInputBorder(),
                                      hintText:
                                          widget.validateHint ?? widget.hint,
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
                                    style: regularStyle.copyWith(
                                        color: Palette.lightBlack),
                                    keyboardType: widget.keyboardType,
                                    obscureText: !_isTextVisible,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    onChanged: (text) {
                                      widget.onValidateChanged?.call(text);
                                    },
                                    readOnly: widget.readOnly,
                                    maxLines: 1,
                                    maxLength: 30,
                                    decoration: InputDecoration(
                                      suffixIcon: widget.isPassword
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                icon: Image.asset(
                                                  _isTextVisible
                                                      ? "assets/icons/login/visible_icon.png"
                                                      : "assets/icons/login/invisible_icon.png",
                                                  width: 24,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isTextVisible =
                                                        !_isTextVisible;
                                                  });
                                                },
                                              ),
                                            )
                                          : null,
                                      counterText: "",
                                      contentPadding: const EdgeInsets.only(
                                        left: 16,
                                      ),
                                      filled: true,
                                      fillColor: Palette.darkWhite,
                                      border: const OutlineInputBorder(),
                                      hintText:
                                          widget.validateHint ?? widget.hint,
                                      hintStyle: regularStyle.copyWith(
                                          color: Palette.grey),
                                      suffixIconConstraints: BoxConstraints(
                                          maxHeight: 24,
                                          maxWidth: widget.suffixWidth ?? 60,
                                          minWidth: 24,
                                          minHeight: 24),
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
                                          bool success = widget
                                                  .onCheckButtonPressed
                                                  ?.call() ??
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                    widget.validateHelperText != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              widget.validateHelperText!,
                              style: lightStyle.copyWith(
                                  color: Palette.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void showTimePickerDialog() {
    final List<String> startHour = [
      "09",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18"
    ];
    final List<String> startMinute = ["00", "10", "20", "30", "40", "50"];
    if(_textController.text.isEmpty) {
      _textController.text = "${startHour.first}:${startMinute.first}";
    }
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.only(bottom: 50),
              color: Palette.white,
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: startHour.indexOf(_textController.text
                              .substring(0, 2))),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        _textController.text = _textController.text
                            .replaceRange(0, 2, startHour[index]);
                      },
                      children: [
                        for (int i = 9; i < 19; i++)
                          Center(
                            child:
                                Text(i.toString().length == 1 ? "0$i" : "$i"),
                          ),
                      ],
                    ),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    child: Text(
                      "시",
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: startMinute.indexOf(_textController.text
                              .substring(3, 5))),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        _textController.text = _textController.text
                            .replaceRange(3, 5, startMinute[index]);
                      },
                      children: [
                        for (int i = 0; i < 6; i++)
                          Center(
                            child: Text("${i}0"),
                          ),
                      ],
                    ),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    child: Text(
                      "분",
                    ),
                  )
                ],
              ));
        });
  }

}
