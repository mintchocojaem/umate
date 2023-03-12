import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';

class LoginFormField extends StatefulWidget{

  final String? title;
  final String? hint;
  final bool checkButton;
  final bool validate;
  final String? validateHint;
  final List<String>? dropdownData;
  final String? checkButtonText;
  final bool readOnly;

  const LoginFormField({
    super.key,
    this.hint,
    this.title,
    this.checkButton = false,
    this.validate = false,
    this.validateHint,
    this.dropdownData,
    this.checkButtonText,
    this.readOnly = false,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginFormField();
  }

}

class _LoginFormField extends State<LoginFormField> {

  final TextEditingController textController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title == null
            ? const SizedBox()
            : Text(widget.title!, style: titleStyle.copyWith(color: Palette.darkGrey),),
        const SizedBox(height: 8,),
        SizedBox(
          height: 48,
          child: TextField(
            enabled: !widget.readOnly,
            readOnly: widget.readOnly,
            controller: textController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.lightGrey,
              border: const OutlineInputBorder(),
              hintText: widget.hint,
              hintStyle: TextStyle(color: Palette.grey),
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
        widget.validate ? Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    readOnly: widget.readOnly,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Palette.lightGrey,
                      border: const OutlineInputBorder(),
                      hintText: widget.validateHint ?? widget.hint,
                      hintStyle: TextStyle(color: Palette.grey),
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
              widget.checkButton ?
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Palette.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Palette.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(widget.checkButtonText ?? "중복확인", style: regularStyle.copyWith(color: Palette.grey),),
                      ),
                    )
                ),
              ) : const SizedBox()
            ],
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
