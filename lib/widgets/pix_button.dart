import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

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
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: HexColor('#a7d8f6'),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: ColorArrays.orangeYellow),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5,
                vertical: SizeConfig.blockSizeVertical * 1),
            child: SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              child: AutoSizeText(name,
                  style: TextStyle(
                    fontFamily: 'CaveatBrush',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    color: HexColor('#4b4272'),
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
        ));
  }
}
