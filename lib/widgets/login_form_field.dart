import 'package:danvery/settings/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings/palette.dart';

class LoginFormField extends StatefulWidget{

  final String? title;
  final String? hint;
  final bool checkButton;
  final bool validate;
  final String? validateHint;
  final bool dropdown;
  final List<String>? dropdownData;
  final String? checkButtonText;

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
            : Text(widget.title!, style: TextStyle(fontSize: FontSize.titleFont, color: Palette.lightGrey, fontWeight: FontWeight.bold),),
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
                    fillColor: Palette.whiteGrey,
                    border: const OutlineInputBorder(),
                    hintText: widget.validateHint ?? widget.hint,
                    hintStyle: TextStyle(color: Palette.lightGrey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Palette.whiteGrey,
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
                  controller: textController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.whiteGrey,
                    border: const OutlineInputBorder(),
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: Palette.lightGrey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Palette.whiteGrey,
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
                    side: MaterialStateProperty.all(BorderSide(color: Palette.lightGrey)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(widget.checkButtonText ?? "중복확인", style: TextStyle(color: Palette.lightGrey),),
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
              decoration: InputDecoration(
                filled: true,
                fillColor: Palette.whiteGrey,
                border: const OutlineInputBorder(),
                hintText: widget.validateHint ?? widget.hint,
                hintStyle: TextStyle(color: Palette.lightGrey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Palette.whiteGrey,
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
