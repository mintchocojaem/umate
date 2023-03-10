import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';

class LoginFormField extends StatefulWidget{

  final String? title;
  final String? hint;
  final bool checkButton;
  final bool validate;
  final String? validateHint;
  final bool dropdown;
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
    this.dropdown = false,
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

  List<String> dropdownData = [];

  final TextEditingController textController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();


  @override
  void initState() {

    if(widget.dropdownData != null){
      dropdownData.addAll(widget.dropdownData!);
    }

    super.initState();
  }

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
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child:  widget.dropdown ? DropdownButtonFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Palette.white,
                    border: const OutlineInputBorder(),
                    hintText: widget.validateHint ?? widget.hint,
                    hintStyle: TextStyle(color: Palette.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Palette.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  //value: dropdownController.text,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownController.text = value!;
                    });
                  },
                  items: dropdownData.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ) : TextField(
                  readOnly: widget.readOnly,
                  controller: textController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.white,
                    border: const OutlineInputBorder(),
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: Palette.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Palette.white,
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
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(color: Palette.white)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(widget.checkButtonText ?? "중복확인", style: regularStyle.copyWith(color: Palette.white),),
                  ),
                )
              ),
            ) : const SizedBox()
          ],
        ),
        widget.validate ? Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: SizedBox(
            height: 48,
            child: TextField(
              readOnly: widget.readOnly,
              decoration: InputDecoration(
                filled: true,
                fillColor: Palette.white,
                border: const OutlineInputBorder(),
                hintText: widget.validateHint ?? widget.hint,
                hintStyle: TextStyle(color: Palette.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Palette.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
