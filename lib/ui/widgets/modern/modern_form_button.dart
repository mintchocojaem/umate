import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/theme/app_text_theme.dart';

class ModernFormButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  const ModernFormButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isEnabled = true})
      : super(key: key);

  @override
  createState() => _ModernFormButton();
}

class _ModernFormButton extends State<ModernFormButton>{

  bool coolDown = false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: CupertinoButton(
        disabledColor: Palette.lightGrey,
        borderRadius: BorderRadius.circular(5),
        color: Palette.blue,
        onPressed: widget.isEnabled && !coolDown ? () async{
          widget.onPressed();
          if(mounted){
            setState(() {
              coolDown = true;
            });
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              coolDown = false;
            });
          }
        } : null,
        child: Text(widget.text,
            style: regularStyle.copyWith(
                color: widget.isEnabled && !coolDown ? Palette.white : Palette.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
