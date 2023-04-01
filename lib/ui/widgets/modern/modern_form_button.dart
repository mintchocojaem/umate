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

  bool isEnabled = true;

  @override
  initState() {
    super.initState();
    isEnabled = widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: CupertinoButton(
        disabledColor: Palette.lightGrey,
        borderRadius: BorderRadius.circular(5),
        color: Palette.blue,
        onPressed: isEnabled ? () async{
          widget.onPressed();
          if(mounted){
            setState(() {
              isEnabled = false;
            });
          }
          Future.delayed(const Duration(seconds: 1), () {
            if(mounted){
              setState(() {
                isEnabled = true;
              });
            }
          });
        } : null,
        child: Text(widget.text,
            style: regularStyle.copyWith(
                color: isEnabled ? Palette.white : Palette.grey)),
      ),
    );
  }
}
