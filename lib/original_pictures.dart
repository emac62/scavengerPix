import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/matching_screen.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:scavenger_hunt_pictures/settings_screen.dart';
import 'package:scavenger_hunt_pictures/widgets/banner_ad_widget.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
import 'package:scavenger_hunt_pictures/widgets/dialogs.dart';
import 'package:scavenger_hunt_pictures/widgets/image_title.dart';
import 'package:scavenger_hunt_pictures/widgets/ordinal.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OriginalPage extends StatefulWidget {
  const OriginalPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _OriginalPageState createState() => _OriginalPageState();
}

class _OriginalPageState extends State<OriginalPage> {
  File? firstImage;
  File? secondImage;
  File? thirdImage;

  String player1 = "";
  String player2 = "";

  BannerAdContainer bannerAdContainer = const BannerAdContainer();

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
    loadSettings();
  }

  getImgUrl(int position) {
    if (position == 0) {
      return firstImage;
    } else if (position == 1) {
      return secondImage;
    } else if (position == 2) {
      return thirdImage;
    }
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
            "Take Original Photos",
            style: TextStyle(
              color: HexColor('#fefefe'),
              fontFamily: 'CaveatBrush',
              fontSize: SizeConfig.blockSizeHorizontal * 8,
              fontWeight: FontWeight.w500,
            ),
          ),
          gradient: LinearGradient(colors: ColorArrays.purple),
          actions: [
            Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1),
                child: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: HexColor('#4b4272'),
                    size: SizeConfig.blockSizeHorizontal * 7,
                  ),
                  onPressed: () {
                    showPlayer1Instructions(context);
                  },
                )),
            Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1),
                child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: HexColor('#4b4272'),
                      size: SizeConfig.blockSizeHorizontal * 7,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                    }))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(colors: ColorArrays.orangeYellow)),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 15,
                        vertical: SizeConfig.blockSizeVertical * 1),
                    child: Column(
                      children: [
                        Text(
                            "Round ${settingsProvider.currentRound} of ${settingsProvider.numberOfRounds}",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 8,
                              fontWeight: FontWeight.w400,
                            )),
                        (settingsProvider.playerTurns == 1)
                            ? Text("$player1 find your Photos!",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                                  fontWeight: FontWeight.w400,
                                ))
                            : Text("$player2 - find your Pics!",
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
                  child: buildImageCard(
                      imgNum: toOrdinal(position + 1),
                      imgUrl: getImgUrl(position) == null
                          ? ""
                          : getImgUrl(position)!.path),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 30),
              child: PixButton(
                  name: "Next",
                  onPressed: () {
                    switch (settingsProvider.numberOfPictures) {
                      case 1:
                        (firstImage == null)
                            ? null
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MatchingPage(
                                      firstImgPath: firstImage!.path,
                                    )));
                        break;
                      case 2:
                        (firstImage == null || secondImage == null)
                            ? null
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MatchingPage(
                                      firstImgPath: firstImage!.path,
                                      secondImgPath: secondImage!.path,
                                    )));
                        break;
                      case 3:
                        (firstImage == null ||
                                secondImage == null ||
                                thirdImage == null)
                            ? null
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MatchingPage(
                                      firstImgPath: firstImage!.path,
                                      secondImgPath: secondImage!.path,
                                      thirdImgPath: thirdImage!.path,
                                    )));
                        break;
                      default:
                    }

                    (firstImage == null ||
                            secondImage == null ||
                            thirdImage == null)
                        ? null
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MatchingPage(
                                  firstImgPath: firstImage!.path,
                                  secondImgPath: secondImage!.path,
                                  thirdImgPath: thirdImage!.path,
                                )));
                  },
                  fontSize: SizeConfig.blockSizeHorizontal * 8),
            ),
          ]),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 3, color: HexColor('#afa6d6')))),
            padding: const EdgeInsets.only(top: 10),
            child: bannerAdContainer),
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
        borderOnForeground: true,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 25, color: HexColor('#4b4272')),
                right: BorderSide(width: 20, color: HexColor('#afa6d6')),
                bottom: BorderSide(width: 25, color: HexColor('#4b4272')),
                left: BorderSide(width: 20, color: HexColor('#afa6d6'))),
            gradient: (Provider.of<SettingsProvider>(context, listen: false)
                        .playerTurns ==
                    1)
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
                title: imgUrl != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageTitle(
                            title: imgNum,
                          ),
                          TextButton(
                            onPressed: () {
                              takePicture(imgNum);
                            },
                            child: Text(
                              "Retake",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: HexColor('#fefefe')),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor('#7d74a4'))),
                          ),
                        ],
                      )
                    : ImageTitle(
                        title: imgNum,
                      ),
                subtitle: imgUrl == ""
                    ? Text(
                        'Take a close up picture within your boundaries!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4),
                      )
                    : null,
              ),
              SizedBox(
                  child: imgUrl == ""
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical * 2),
                          child: GestureDetector(
                            onTap: () {
                              takePicture(imgNum);
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black38,
                              size: SizeConfig.blockSizeVertical * 10,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: FileImage(File(imgUrl)),
                            fit: BoxFit.contain,
                          ),
                        )),
            ],
          ),
        ));
  }
}
