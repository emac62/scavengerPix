// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/compare_images.dart';
import 'package:scavenger_hunt_pictures/full_screen_image.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
import 'package:scavenger_hunt_pictures/widgets/dialogs.dart';
import 'package:scavenger_hunt_pictures/widgets/image_title.dart';
import 'package:scavenger_hunt_pictures/widgets/ordinal.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchingPage extends StatefulWidget {
  final String firstImgPath;
  String? secondImgPath;
  String? thirdImgPath;
  MatchingPage(
      {Key? key,
      required this.firstImgPath,
      this.secondImgPath,
      this.thirdImgPath})
      : super(
          key: key,
        );

  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  File? fourthImage;
  File? fifthImage;
  File? sixthImage;

  var player1;
  var player2;

  loadSettings() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      player1 = (savedPref.getString('player1') ?? "Player1");
      player2 = (savedPref.getString('player2') ?? "Player2");
    });
  }

  @override
  initState() {
    super.initState();
    loadSettings().then((_) {
      int playerTurns =
          Provider.of<SettingsProvider>(context, listen: false).playerTurns + 1;
      Provider.of<SettingsProvider>(context, listen: false)
          .setPlayerTurns(playerTurns);
    });
  }

  getImgUrl(int position) {
    if (position == 0) {
      return fourthImage;
    } else if (position == 1) {
      return fifthImage;
    } else if (position == 2) {
      return sixthImage;
    }
  }

  getImgUrlCompare(int position) {
    if (position == 0) {
      return widget.firstImgPath;
    } else if (position == 1) {
      return widget.secondImgPath;
    } else if (position == 2) {
      return widget.thirdImgPath;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: AutoSizeText(
          "Match the Pics",
          style: TextStyle(
            color: HexColor('#fefefe'),
            fontFamily: 'CaveatBrush',
            fontSize: SizeConfig.blockSizeHorizontal * 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        gradient: LinearGradient(colors: ColorArrays.purple),
        actions: [
          Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              child: GestureDetector(
                child: Icon(
                  Icons.info,
                  color: AppColor.iconColor,
                ),
                onTap: () {
                  showPlayer2Instructions(context);
                },
              )),
          Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.restart_alt,
                    color: AppColor.iconColor,
                  ),
                ),
                onTap: () {
                  restartGame(context);
                },
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: ColorArrays.orangeYellow)),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 8,
                      vertical: SizeConfig.blockSizeVertical * 1),
                  child: Column(
                    children: [
                      Text(
                          "Round ${settingsProvider.currentRound} of ${settingsProvider.numberOfRounds}",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 8,
                            fontWeight: FontWeight.w400,
                          )),
                      (settingsProvider.playerTurns == 2)
                          ? Text("$player2 match the Pics!",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.w400,
                              ))
                          : Text("$player1 - match the Pics!",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.w400,
                              )),
                    ],
                  )),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: settingsProvider.numberOfPictures,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildPlayer2ImageCard(
                    imgNum: toOrdinal(position + 4),
                    imgUrl: getImgUrl(position) == null
                        ? ""
                        : getImgUrl(position)!.path,
                    imgNumCompare: toOrdinal(position + 1),
                    imgUrlCompare: getImgUrlCompare(position)),
              );
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PixButton(
                name: "Next",
                onPressed: () {
                  switch (settingsProvider.numberOfPictures) {
                    case 1:
                      fourthImage == null
                          ? null
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompareImages(
                                    firstImgPath: widget.firstImgPath,
                                    fourthImgPath: fourthImage!.path,
                                  )));
                      break;
                    case 2:
                      (fourthImage == null || fifthImage == null)
                          ? null
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompareImages(
                                    firstImgPath: widget.firstImgPath,
                                    fourthImgPath: fourthImage!.path,
                                    secondImgPath: widget.secondImgPath,
                                    fifthImgPath: fifthImage!.path,
                                  )));
                      break;
                    case 3:
                      (fourthImage == null ||
                              fifthImage == null ||
                              sixthImage == null)
                          ? null
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompareImages(
                                    firstImgPath: widget.firstImgPath,
                                    fourthImgPath: fourthImage!.path,
                                    secondImgPath: widget.secondImgPath,
                                    fifthImgPath: fifthImage!.path,
                                    thirdImgPath: widget.thirdImgPath,
                                    sixthImgPath: sixthImage!.path,
                                  )));
                      break;
                    default:
                  }

                  (fourthImage == null ||
                          fifthImage == null ||
                          sixthImage == null)
                      ? null
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CompareImages(
                                firstImgPath: widget.firstImgPath,
                                secondImgPath: widget.secondImgPath,
                                thirdImgPath: widget.thirdImgPath,
                                fourthImgPath: fourthImage!.path,
                                fifthImgPath: fifthImage!.path,
                                sixthImgPath: sixthImage!.path,
                              )));
                },
                fontSize: SizeConfig.blockSizeHorizontal * 8),
          )
        ]),
      ),
      bottomNavigationBar: Container(
        color: Colors.black26,
        child: const SizedBox(
          height: 60,
          child: Center(child: Text("Banner Ad")),
        ),
      ),
    );
  }

  Future<void> takePicture(String numPix) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;

    setState(() {
      switch (numPix) {
        case ("4th"):
          fourthImage = File(imageFile.path);
          break;
        case ("5th"):
          fifthImage = File(imageFile.path);
          break;
        case ("6th"):
          sixthImage = File(imageFile.path);
          break;
        default:
          break;
      }
    });
  }

  Card buildPlayer2ImageCard({
    required String imgNum,
    required String imgNumCompare,
    required String imgUrl,
    required String imgUrlCompare,
  }) {
    return Card(
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 15, color: HexColor('#4b4272')),
                right: BorderSide(width: 20, color: HexColor('#afa6d6')),
                bottom: BorderSide(width: 25, color: HexColor('#4b4272')),
                left: BorderSide(width: 18, color: HexColor('#afa6d6'))),
            gradient: (Provider.of<SettingsProvider>(context, listen: false)
                        .playerTurns ==
                    4)
                ? LinearGradient(
                    colors: [
                      Color(
                          Provider.of<SettingsProvider>(context, listen: false)
                              .p1ColorInt),
                      Colors.white,
                      Color(
                          Provider.of<SettingsProvider>(context, listen: false)
                              .p1ColorInt),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Color(
                          Provider.of<SettingsProvider>(context, listen: false)
                              .p2ColorInt),
                      Colors.white,
                      Color(
                          Provider.of<SettingsProvider>(context, listen: false)
                              .p2ColorInt),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageTitle(
                      title: imgNumCompare,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FullscreenImage(
                                  imagePix: imgNumCompare,
                                  imageUrl: imgUrlCompare,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Match this Pic",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              color: HexColor('#fefefe')),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor('#7d74a4'))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: GestureDetector(
                    onTap: () => takePicture(imgNum),
                    child: imgUrl == ""
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.black38,
                            size: SizeConfig.blockSizeVertical * 10,
                          )
                        : Image(
                            image: FileImage(File(imgUrl)),
                            fit: BoxFit.contain,
                          )),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: imgUrl != ""
                        ? PixButton(
                            name: "Retake",
                            onPressed: () => takePicture(imgNum),
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                          )
                        : null,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
