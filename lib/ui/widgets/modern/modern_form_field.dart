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
  final String? initCurrentPasswordText;
  final String? currentPasswordHint;
  final bool checkButton;
  final bool validate;
  final String? validateHint;
  final String? checkButtonText;
  final bool readOnly;
  final bool isPassword;
  final bool addCurrentPassword;
  final bool isSMS;
  final Future<bool> Function()? onCheckButtonPressed;
  final void Function(String text)? onCurrentPasswordTextChanged;
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
  final bool isDay;
  final bool isTime;
  final int maxLength;

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
    this.addCurrentPassword = false,
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
    this.isDay = false,
    this.isTime = false,
    this.initCurrentPasswordText,
    this.currentPasswordHint,
    this.onCurrentPasswordTextChanged,
    this.maxLength = 30,
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
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _remainingTime = widget.checkButtonCoolDown;
    _currentPasswordController.text = widget.initCurrentPasswordText ?? "";
    _textController.text = widget.initText ?? "";
    _validateController.text = widget.initValidateText ?? "";

    if(widget.isPassword){
      _isTextVisible = false;
    }else if(widget.addCurrentPassword){
      _isTextVisible = false;
    }

    _textController.addListener(() {
      widget.onTextChanged?.call(_textController.text);
    });
    _validateController.addListener(() {
      widget.onValidateChanged?.call(_validateController.text);
    });
    _currentPasswordController.addListener(() {
      widget.onCurrentPasswordTextChanged?.call(_currentPasswordController.text);
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
            : Column(
                children: [
                  Text(
                    widget.title!,
                    style: smallTitleStyle.copyWith(
                        color: widget.titleColor ?? Palette.darkGrey,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.addCurrentPassword
                ? Column(
                  children: [
                    TextFormField(
                        controller: _currentPasswordController,
                        obscureText: !_isTextVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        enabled: !widget.readOnly,
                        readOnly: widget.readOnly || widget.isTime || widget.isDay,
                        keyboardType: widget.keyboardType,
                        maxLines: 1,
                        maxLength: widget.maxLength,
                        style: regularStyle.copyWith(color: Palette.lightBlack),
                        cursorColor: widget.titleColor ?? Palette.blue,
                        decoration: InputDecoration(
                          helperStyle: regularStyle.copyWith(color: Palette.grey),
                          counterText: "",
                          filled: true,
                          fillColor: Palette.darkWhite,
                          border: const OutlineInputBorder(),
                          hintText: widget.currentPasswordHint,
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
                          suffixIcon: Padding(
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
                          ),
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
                    const SizedBox(height: 8,),
                  ],
                )
                : const SizedBox(),
            TextFormField(
              onTap: widget.isTime
                  ? showTimePickerDialog
                  : widget.isDay
                      ? showDayPickerDialog
                      : null,
              controller: _textController,
              obscureText: !_isTextVisible,
              enableSuggestions: false,
              autocorrect: false,
              enabled: !widget.readOnly,
              readOnly: widget.readOnly || widget.isTime || widget.isDay,
              keyboardType: widget.keyboardType,
              maxLines: 1,
              maxLength: widget.maxLength,
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
                suffixIcon: widget.isPassword || widget.addCurrentPassword
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
                            ? showTimePickerDialog
                            : widget.isDay
                                ? showDayPickerDialog
                                : null,
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
                      style: lightStyle.copyWith(color: Palette.blue),
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
                                    maxLength: widget.maxLength,
                                    decoration: InputDecoration(
                                      suffixIcon: widget.isPassword ||
                                              widget.addCurrentPassword
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
                                          if (await widget.onCheckButtonPressed
                                              ?.call() ?? false) _coolDown();
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

  void showDayPickerDialog() {
    final List<String> days = [
      "월",
      "화",
      "수",
      "목",
      "금",
    ];
    if (_textController.text.isEmpty) {
      _textController.text = days.first;
    }
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 50),
          color: Palette.white,
          height: 250,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: days.indexOf(_textController.text),
            ),
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              _textController.text = days[index];
            },
            children: days
                .map(
                  (e) => Center(
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void showTimePickerDialog() {
    int startTime = 9;
    int endTime = 24;
    int minuteInterval = 10;

    final List<String> startHour = [
      for (int i = startTime; i < endTime; i++) i.toString().padLeft(2, "0")
    ];
    final List<String> startMinute = [
      for (int i = 0; i < 60; i += minuteInterval) i.toString().padLeft(2, "0")
    ];

    if (_textController.text.isEmpty) {
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
                    initialItem: startHour.indexOf(
                      _textController.text.substring(0, 2),
                    ),
                  ),
                  itemExtent: 40,
                  onSelectedItemChanged: (index) {
                    _textController.text = _textController.text
                        .replaceRange(0, 2, startHour[index]);
                  },
                  children: [
                    for (int i = startTime; i < endTime; i++)
                      Center(
                        child: Text(i.toString().padLeft(2, "0")),
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
                    initialItem: startMinute.indexOf(
                      _textController.text.substring(3, 5),
                    ),
                  ),
                  itemExtent: 40,
                  onSelectedItemChanged: (index) {
                    _textController.text = _textController.text
                        .replaceRange(3, 5, startMinute[index]);
                  },
                  children: [
                    for (int i = 0; i < 60; i += minuteInterval)
                      Center(
                        child: Text(i.toString().padLeft(2, "0")),
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
          ),
        );
      },
    );
  }
}
