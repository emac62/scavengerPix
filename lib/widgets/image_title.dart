import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class ImageTitle extends StatelessWidget {
  final String title;
  const ImageTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AutoSizeText(
        "$title Photo",
        style: TextStyle(
            color: HexColor('#2d3a64'),
            fontSize: (SizeConfig.blockSizeHorizontal * 6),
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
