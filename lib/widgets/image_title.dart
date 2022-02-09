import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
        "$title Pix",
        style: TextStyle(
            fontSize: (SizeConfig.blockSizeHorizontal * 8),
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
