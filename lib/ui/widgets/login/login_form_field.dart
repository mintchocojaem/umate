import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../utils/theme/app_text_theme.dart';
import '../../../utils/theme/palette.dart';

class LoginFormField extends StatefulWidget {
  final String? title;
  final String? hint;
  final bool checkButton;
  final bool validate;
  final String? validateHint;
  final TextEditingController? validateController;
  final String? checkButtonText;
  final bool readOnly;
  final TextEditingController? textController;
  final bool isPassword;
  final bool isSMS;
  final bool Function()? onCheckButtonPressed;
  final int checkButtonCoolDown;

  const LoginFormField({
    super.key,
    this.hint,
    this.title,
    this.checkButton = false,
    this.validate = false,
    this.validateHint,
    this.checkButtonText,
    this.readOnly = false,
    this.textController,
    this.isPassword = false,
    this.isSMS = false,
    this.onCheckButtonPressed,
    this.checkButtonCoolDown = 30,
    this.validateController,
  });

  @override
  createState() => _LoginFormField();
}

class _LoginFormField extends State<LoginFormField> {
  late int _remainingTime;
  final FocusNode focusSMS = FocusNode();
  bool _isSend = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.checkButtonCoolDown;
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
                    color: Palette.grey, fontWeight: FontWeight.w500),
              ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 48,
          child: TextFormField(
            obscureText: widget.isPassword,
            enableSuggestions: false,
            autocorrect: false,
            enabled: !widget.readOnly,
            readOnly: widget.readOnly,
            controller: widget.textController,
            style:
                TextStyle(color: Palette.darkGrey, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.lightGrey,
              border: const OutlineInputBorder(),
              hintText: widget.hint,
              hintStyle: regularStyle.copyWith(
                  color: widget.readOnly ? Palette.darkGrey : Palette.grey,
                  fontWeight: FontWeight.bold),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Palette.lightGrey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Palette.lightGrey,
                  width: 1.0,
                ),
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
                                focusNode: focusSMS,
                                currentCode: widget.validateController?.text,
                                style: TextStyle(
                                    color: Palette.darkGrey,
                                    fontWeight: FontWeight.bold),
                                codeLength: 6,
                                autoFocus: false,
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Palette.lightGrey,
                                  border: const OutlineInputBorder(),
                                  hintText: widget.validateHint ?? widget.hint,
                                  hintStyle: regularStyle.copyWith(
                                      color: Palette.grey,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Palette.lightGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                onCodeChanged: (code) {
                                  widget.validateController?.text = code;
                                  if(code.length == 6) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              )
                            : TextFormField(
                                style: TextStyle(
                                    color: Palette.darkGrey,
                                    fontWeight: FontWeight.bold),
                                obscureText: widget.isPassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                controller: widget.validateController,
                                readOnly: widget.readOnly,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Palette.lightGrey,
                                  border: const OutlineInputBorder(),
                                  hintText: widget.validateHint ?? widget.hint,
                                  hintStyle: regularStyle.copyWith(
                                      color: Palette.grey,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Palette.lightGrey,
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
                                  onPressed: () async{
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
                                              ? Palette.lightBlue
                                              : Palette.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: !_isSend
                                          ? Palette.lightBlue
                                          : Palette.white),
                                  child: Center(
                                    child: Text(
                                      _isSend
                                          ? "$_remainingTime"
                                          : "${widget.checkButtonText}",
                                      style: regularStyle.copyWith(
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
