import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
            primary: HexColor('#4A5E43'), onPrimary: HexColor('#E7E6DC')),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AutoSizeText(
            name,
            style: TextStyle(
              color: HexColor('#E7E6DC'),
              fontFamily: 'CaveatBrush',
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }
}
