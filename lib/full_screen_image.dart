import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavenger_hunt_pictures/widgets/banner_ad_widget.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
import 'package:scavenger_hunt_pictures/widgets/font_sizes.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class FullscreenImage extends StatefulWidget {
  final String imageUrl;
  final String imagePix;
  const FullscreenImage(
      {super.key, required this.imageUrl, required this.imagePix});

  @override
  State<FullscreenImage> createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {
  BannerAdContainer bannerAdContainer = const BannerAdContainer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: HexColor('#fefefe')),
        title: AutoSizeText(
          '${widget.imagePix} Pic',
          style: TextStyle(
            fontSize: getHeadingFontSize(),
            color: HexColor('#fefefe'),
          ),
        ),
        backgroundColor: ColorArrays.purple.first,
        elevation: 0,
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
          child: SafeArea(top: false, child: bannerAdContainer)),
    );
  }
}
