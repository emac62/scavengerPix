import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/matching_screen.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';
import 'package:scavenger_hunt_pictures/widgets/dialogs.dart';
import 'package:scavenger_hunt_pictures/widgets/image_title.dart';
import 'package:scavenger_hunt_pictures/widgets/ordinal.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OriginalPage extends StatefulWidget {
  const OriginalPage({Key? key})
      : super(
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
    loadSettings().then((_) {});

    debugPrint(
        'Original init playerTurns: ${Provider.of<SettingsProvider>(context, listen: false).playerTurns}');
    debugPrint(
        'Original init player1: ${Provider.of<SettingsProvider>(context, listen: false).player1}');
    debugPrint(
        'Original init player2: ${Provider.of<SettingsProvider>(context, listen: false).player2}');
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
    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: AutoSizeText(
          "Take Original Pics",
          style: TextStyle(
            color: HexColor('#2d3a64'),
            fontFamily: 'CaveatBrush',
            fontSize: SizeConfig.blockSizeHorizontal * 8,
            fontWeight: FontWeight.w500,
          ),
        ),
        gradient: LinearGradient(colors: [
          HexColor('#d5ebf6'),
          HexColor('#007cc2'),
          HexColor('#d5ebf6'),
        ]),
        actions: [
          Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info,
                    color: HexColor('#f6911f'),
                  ),
                ),
                onTap: () {
                  showPlayer1Instructions(context);
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Card(
            elevation: 10,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffbb8b1f), Color(0xffffdf21)])),
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
                      (settingsProvider.playerTurns == 1)
                          ? Text("$player1 find your Pics!",
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
            padding: const EdgeInsets.all(10.0),
            child: PixButton(
                name: "Next",
                onPressed: () {
                  int playerTurns = settingsProvider.playerTurns + 1;
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setPlayerTurns(playerTurns);
                  switch (settingsProvider.numberOfPictures) {
                    case 1:
                      firstImage == null
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
        borderOnForeground: true,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 15, color: AppColor.orange),
                right: BorderSide(width: 20, color: AppColor.yellow),
                bottom: BorderSide(width: 25, color: AppColor.yellow),
                left: BorderSide(width: 18, color: AppColor.orange)),
            gradient: LinearGradient(
              colors: [AppColor.yellow, AppColor.orange],
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
                          PixButton(
                            name: "Retake",
                            onPressed: () {
                              takePicture(imgNum);
                            },
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                          ),
                        ],
                      )
                    : ImageTitle(
                        title: imgNum,
                      ),
                subtitle: imgUrl == ""
                    ? Text(
                        'Take a close up picture',
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
