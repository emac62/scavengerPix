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
import 'package:scavenger_hunt_pictures/widgets/dialogs.dart';
import 'package:scavenger_hunt_pictures/widgets/image_title.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class Player2Page extends StatefulWidget {
  final String firstImgPath;
  final String secondImgPath;
  final String thirdImgPath;
  const Player2Page(
      {Key? key,
      required this.firstImgPath,
      required this.secondImgPath,
      required this.thirdImgPath})
      : super(
          key: key,
        );

  @override
  _Player2PageState createState() => _Player2PageState();
}

class _Player2PageState extends State<Player2Page> {
  File? fourthImage;
  File? fifthImage;
  File? sixthImage;

//ToDo: Load img1/2/3

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: NewGradientAppBar(
          automaticallyImplyLeading: false,
          title: AutoSizeText(
            "Match the Pics",
            style: TextStyle(
              color: HexColor('#E7E6DC'),
              fontFamily: 'CaveatBrush',
              fontSize: SizeConfig.blockSizeHorizontal * 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          gradient: LinearGradient(
              colors: [HexColor('#9E9A75'), HexColor('#4A5E43')]),
          actions: [
            Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                child: GestureDetector(
                  child: Icon(
                    Icons.info,
                    color: HexColor('#E7E6DC'),
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
                      color: HexColor('#E7E6DC'),
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical * 1),
              child: Text("Round 1",
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 8,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical * 1),
              child: AutoSizeText(
                "${settingsProvider.player2} match ${settingsProvider.player1}'s Pictures!",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                minFontSize: 18,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildPlayer2ImageCard(
                  imgNum: "4th",
                  imgNumCompare: "1st",
                  imgUrl: fourthImage == null ? "" : fourthImage!.path,
                  imgUrlCompare: widget.firstImgPath),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildPlayer2ImageCard(
                  imgNum: "5th",
                  imgNumCompare: "2nd",
                  imgUrl: fifthImage == null ? "" : fifthImage!.path,
                  imgUrlCompare: widget.secondImgPath),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildPlayer2ImageCard(
                  imgNum: "6th",
                  imgNumCompare: "3rd",
                  imgUrl: sixthImage == null ? "" : sixthImage!.path,
                  imgUrlCompare: widget.thirdImgPath),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: PixButton(
                  name: "Next",
                  onPressed: () {
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
                  fontSize: SizeConfig.blockSizeHorizontal * 4),
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
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageTitle(
                    title: imgNumCompare,
                  ),
                  PixButton(
                    name: "Match this Pic",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FullscreenImage(
                                imagePix: imgNumCompare,
                                imageUrl: imgUrlCompare,
                              )));
                    },
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                  )
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
        ));
  }
}
