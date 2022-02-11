import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:scavenger_hunt_pictures/full_screen_image.dart';
import 'package:scavenger_hunt_pictures/player2.dart';
import 'package:scavenger_hunt_pictures/widgets/dialogs.dart';
import 'package:scavenger_hunt_pictures/widgets/image_title.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class Player1Page extends StatefulWidget {
  const Player1Page({Key? key})
      : super(
          key: key,
        );

  @override
  _Player1PageState createState() => _Player1PageState();
}

class _Player1PageState extends State<Player1Page> {
  File? firstImage;
  File? secondImage;
  File? thirdImage;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: AutoSizeText(
          "Take Original Pics",
          style: TextStyle(
            color: HexColor('#E7E6DC'),
            fontFamily: 'CaveatBrush',
            fontSize: SizeConfig.blockSizeHorizontal * 8,
            fontWeight: FontWeight.w400,
          ),
        ),
        gradient:
            LinearGradient(colors: [HexColor('#9E9A75'), HexColor('#4A5E43')]),
        actions: [
          Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info,
                    color: HexColor('#E7E6DC'),
                  ),
                ),
                onTap: () {
                  showPlayer1Instructions(context);
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 3,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: buildImageCard(
                  imgNum: "1st",
                  imgUrl: firstImage == null ? "" : firstImage!.path,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3,
                      vertical: SizeConfig.blockSizeVertical * 2),
                  child: buildImageCard(
                    imgNum: "2nd",
                    imgUrl: secondImage == null ? "" : secondImage!.path,
                  )),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3,
                      vertical: SizeConfig.blockSizeVertical * 2),
                  child: buildImageCard(
                    imgNum: "3rd",
                    imgUrl: thirdImage == null ? "" : thirdImage!.path,
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PixButton(
                    name: "Next",
                    onPressed: () {
                      (firstImage == null ||
                              secondImage == null ||
                              thirdImage == null)
                          ? null
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Player2Page(
                                    firstImgPath: firstImage!.path,
                                    secondImgPath: secondImage!.path,
                                    thirdImgPath: thirdImage!.path,
                                  )));
                    },
                    fontSize: SizeConfig.blockSizeHorizontal * 4),
              ),
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
      imageQuality: 80,
      maxWidth: 600,
    );
    if (imageFile == null) return;

    setState(() {
      switch (numPix) {
        case ("1st"):
          firstImage = File(imageFile.path);

          break;
        case ("2nd"):
          secondImage = File(imageFile.path);

          break;
        case ("3rd"):
          thirdImage = File(imageFile.path);

          break;
        default:
          break;
      }
    });
  }

  Card buildImageCard({
    required String imgNum,
    required String imgUrl,
  }) {
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: ImageTitle(
                title: imgNum,
              ),
              subtitle: const Text(
                'Take a close up picture',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              child: GestureDetector(
                  onTap: () {
                    takePicture(imgNum);
                  },
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
                  child: PixButton(
                    name: "Retake",
                    onPressed: () {
                      takePicture(imgNum);
                    },
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PixButton(
                      name: "Enlarge",
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      onPressed: () {
                        imgUrl == ""
                            ? null
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FullscreenImage(
                                      imagePix: imgNum,
                                      imageUrl: imgUrl,
                                    )));
                      }),
                ),
              ],
            )
          ],
        ));
  }
}