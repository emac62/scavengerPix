import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:scavenger_hunt_pictures/widgets/banner_ad_widget.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
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
  BannerAdContainer bannerAdContainer = const BannerAdContainer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: AutoSizeText(
          '${widget.imagePix} Pic',
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 8,
            color: HexColor('#fefefe'),
          ),
        ),
        gradient: LinearGradient(colors: ColorArrays.purple),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
        child: Image(
          image: FileImage(File(widget.imageUrl)),
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 3, color: HexColor('#afa6d6')))),
          padding: const EdgeInsets.only(top: 5),
          child: bannerAdContainer),
    );
  }
}
