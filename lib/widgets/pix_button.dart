import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';

class PixButton extends StatelessWidget {
  final String name;
  final GestureTapCallback onPressed;
  final double fontSize;
  const PixButton(
      {Key? key,
      required this.name,
      required this.onPressed,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: AppColor.orange, onPrimary: AppColor.textColor),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AutoSizeText(
            name,
            style: TextStyle(
              fontFamily: 'CaveatBrush',
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }
}
