import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class FullscreenImage extends StatefulWidget {
  final String imageUrl;
  final String imagePix;
  const FullscreenImage(
      {Key? key, required this.imageUrl, required this.imagePix})
      : super(key: key);

  @override
  State<FullscreenImage> createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: AutoSizeText(
          '${widget.imagePix} Pic',
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 8),
        ),
        gradient:
            LinearGradient(colors: [HexColor('#9E9A75'), HexColor('#4A5E43')]),
      ),
      body: Image(
        image: FileImage(File(widget.imageUrl)),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
