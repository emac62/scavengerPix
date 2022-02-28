// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/original_pictures.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:scavenger_hunt_pictures/settings_screen.dart';
import 'package:scavenger_hunt_pictures/widgets/ad_helper.dart';
import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';
import 'package:scavenger_hunt_pictures/widgets/banner_ad_widget.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
import 'package:scavenger_hunt_pictures/widgets/dialogs.dart';
import 'package:scavenger_hunt_pictures/widgets/ordinal.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompareImages extends StatefulWidget {
  final String firstImgPath;
  String? secondImgPath;
  String? thirdImgPath;
  final String fourthImgPath;
  String? fifthImgPath;
  String? sixthImgPath;

  CompareImages(
      {Key? key,
      required this.firstImgPath,
      this.secondImgPath,
      this.thirdImgPath,
      required this.fourthImgPath,
      this.fifthImgPath,
      this.sixthImgPath})
      : super(key: key);

  @override
  _CompareImagesState createState() => _CompareImagesState();
}

class _CompareImagesState extends State<CompareImages>
    with SingleTickerProviderStateMixin {
  File? firstImgPath;
  File? secondImgPath;
  File? thirdImgPath;
  File? fourthImgPath;
  File? fifthImgPath;
  File? sixthImgPath;
  bool same1 = false;
  bool notSame1 = false;
  bool same2 = false;
  bool notSame2 = false;
  bool same3 = false;
  bool notSame3 = false;
  int numberCorrect = 0;
  int numberIncorrect = 0;
  var player1 = "";
  var player2 = "";
  bool scoreUpdated = false;

  late AnimationController animationController;
  late Animation<double> animation;
  BannerAdContainer bannerAdContainer = const BannerAdContainer();
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  var p1Score = 0;
  var p2Score = 0;

  setSame(int position) {
    if (position == 0) {
      return same1;
    } else if (position == 1) {
      return same2;
    } else if (position == 2) {
      return same3;
    }
  }

  setNotSame(int position) {
    if (position == 0) {
      return notSame1;
    } else if (position == 1) {
      return notSame2;
    } else if (position == 2) {
      return notSame3;
    }
  }

  getP1ImgPath(int position) {
    if (position == 0) {
      return firstImgPath!;
    } else if (position == 1) {
      return secondImgPath!;
    } else if (position == 2) {
      return thirdImgPath!;
    }
  }

  getP2ImgPath(int position) {
    if (position == 0) {
      return fourthImgPath!;
    } else if (position == 1) {
      return fifthImgPath!;
    } else if (position == 2) {
      return sixthImgPath!;
    }
  }

  toggleSame1() {
    setState(() {
      if (notSame1 == true) {
        numberIncorrect = -1;
      }
      if (same1 == false) {
        same1 = !same1;
        numberCorrect += 1;
      } else {
        same1 = !same1;
        numberCorrect -= 1;
      }
      notSame1 = false;
      debugPrint('$numberCorrect');
    });
  }

  toggleSame2() {
    setState(() {
      if (notSame2 == true) {
        numberIncorrect = -1;
      }
      if (same2 == false) {
        same2 = !same2;
        numberCorrect += 1;
      } else {
        same2 = !same2;
        numberCorrect -= 1;
      }
      notSame2 = false;
      debugPrint('$numberCorrect');
    });
  }

  toggleSame3() {
    setState(() {
      if (notSame3 == true) {
        numberIncorrect = -1;
      }
      if (same3 == false) {
        same3 = !same3;
        numberCorrect += 1;
      } else {
        same3 = !same3;
        numberCorrect -= 1;
      }
      notSame3 = false;
    });
  }

  toggleNotSame1() {
    setState(() {
      if (same1 == true) {
        numberCorrect -= 1;
      }
      if (notSame1 == false) {
        notSame1 = !notSame1;
        numberIncorrect += 1;
      } else {
        notSame1 = !notSame1;
        numberIncorrect -= 1;
      }
      same1 = false;
    });
  }

  toggleNotSame2() {
    setState(() {
      if (same2 == true) {
        numberCorrect -= 1;
      }
      if (notSame2 == false) {
        notSame2 = !notSame2;
        numberIncorrect += 1;
      } else {
        notSame2 = !notSame2;
        numberIncorrect -= 1;
      }
      same2 = false;
    });
  }

  toggleNotSame3() {
    setState(() {
      if (same3 == true) {
        numberCorrect -= 1;
      }
      if (notSame3 == false) {
        notSame3 = !notSame3;
        numberIncorrect += 1;
      } else {
        notSame3 = !notSame3;
        numberIncorrect -= 1;
      }
      same3 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setVariables();
    loadSettings();
    scoreUpdated = false;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          debugPrint("Failed to Load Interstitial Ad ${error.message}");
        }));
  }

  loadSettings() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      player1 = (savedPref.getString('player1') ?? "Player1");
      player2 = (savedPref.getString('player2') ?? "Player2");
    });
  }

  @override
  void dispose() {
    super.dispose();

    _interstitialAd!.dispose();
  }

  setVariables() {
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    switch (settingsProvider.numberOfPictures) {
      case 1:
        firstImgPath = File(widget.firstImgPath);
        fourthImgPath = File(widget.fourthImgPath);
        break;
      case 2:
        firstImgPath = File(widget.firstImgPath);
        fourthImgPath = File(widget.fourthImgPath);
        secondImgPath = File(widget.secondImgPath!);
        fifthImgPath = File(widget.fifthImgPath!);
        break;
      case 3:
        firstImgPath = File(widget.firstImgPath);
        fourthImgPath = File(widget.fourthImgPath);
        secondImgPath = File(widget.secondImgPath!);
        fifthImgPath = File(widget.fifthImgPath!);
        thirdImgPath = File(widget.thirdImgPath!);
        sixthImgPath = File(widget.sixthImgPath!);

        break;
      default:
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
            "Compare Photos",
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
                child: IconButton(
                    icon: Icon(
                      Icons.restart_alt,
                      color: HexColor('#4b4272'),
                      size: SizeConfig.blockSizeHorizontal * 7,
                    ),
                    onPressed: () {
                      restartGame(
                          context, _isInterstitialAdReady, _interstitialAd!);
                    })),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient:
                            LinearGradient(colors: ColorArrays.orangeYellow)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$player1 and $player2 work together to decide if the photos match!",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: settingsProvider.numberOfPictures,
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildCompareCard(
                        p1Img: toOrdinal(position + 1),
                        p1ImgPath: getP1ImgPath(position),
                        p2ImgPath: getP2ImgPath(position),
                        same: setSame(position),
                        notSame: setNotSame(position)),
                  );
                },
              ),
              (numberCorrect + numberIncorrect !=
                      settingsProvider.numberOfPictures)
                  ? Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient:
                                LinearGradient(colors: ColorArrays.purple)),
                        width: SizeConfig.blockSizeHorizontal * 95,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeVertical * 3,
                                vertical: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Results',
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 10,
                                  color: HexColor('#fefefe')),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeVertical * 3,
                                vertical: SizeConfig.blockSizeVertical * 2),
                            child: AutoSizeText(
                              "Click 'Yes' or 'No' for each pair of photos in this round to update the score",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                                  color: HexColor('#fefefe')),
                            ),
                          ),
                        ]),
                      ),
                    )
                  : Card(
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: ColorArrays.purple,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          border: Border(
                              top: BorderSide(
                                  width: 25, color: HexColor('#f0a142')),
                              right: BorderSide(
                                  width: 20, color: HexColor('#ffffa6')),
                              bottom: BorderSide(
                                  width: 25, color: HexColor('#ffffa6')),
                              left: BorderSide(
                                  width: 20, color: HexColor('#f0a142'))),
                        ),
                        width: SizeConfig.blockSizeHorizontal * 95,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeVertical * 3,
                                vertical: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Results',
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 10,
                                  color: HexColor('#fefefe')),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeVertical * 3,
                                vertical: SizeConfig.blockSizeVertical * 2),
                            child: (settingsProvider.playerTurns == 2 ||
                                    settingsProvider.playerTurns == 3)
                                ? numberCorrect > 0
                                    ? AutoSizeText(
                                        "$player2 got $numberCorrect correct!",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            color: HexColor('#fefefe')),
                                      )
                                    : AutoSizeText(
                                        "Sorry $player2, keep trying!",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            color: HexColor('#fefefe')),
                                      )
                                : numberCorrect > 0
                                    ? AutoSizeText(
                                        "$player1 got $numberCorrect correct!",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            color: HexColor('#fefefe')),
                                      )
                                    : AutoSizeText(
                                        "Sorry $player1, keep trying!",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            color: HexColor('#fefefe')),
                                      ),
                          ),
                          settingsProvider.keepScore
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.blockSizeVertical * 3,
                                      vertical:
                                          SizeConfig.blockSizeVertical * 2),
                                  child: TextButton(
                                    child: Text(
                                      "Update Score",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  8,
                                          color: AppColor.orange),
                                    ),
                                    onPressed: () {
                                      scoreUpdated == false
                                          ? updatePlayerScore()
                                          : null;
                                      showScore(
                                          context,
                                          player1,
                                          player2,
                                          settingsProvider.p1Score,
                                          settingsProvider.p2Score);
                                    },
                                  ),
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeVertical * 3,
                                vertical: SizeConfig.blockSizeVertical * 3),
                            child: (settingsProvider.playerTurns == 4 &&
                                    settingsProvider.currentRound ==
                                        settingsProvider
                                            .numberOfRounds) //End of Game
                                ? PixButton(
                                    name: getFinalButtonTitle(),
                                    onPressed: () {
                                      setState(() {
                                        scoreUpdated == false
                                            ? updatePlayerScore()
                                            : null;
                                        updateRound();
                                      });

                                      imageCache!.clear();

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SettingsScreen()));
                                    },
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5)
                                : PixButton(
                                    //Switch to finish
                                    name: getFinalButtonTitle(),
                                    onPressed: () {
                                      setState(() {
                                        scoreUpdated == false
                                            ? updatePlayerScore()
                                            : null;
                                        updateRound();
                                      });

                                      imageCache!.clear();

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OriginalPage()));
                                    },
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5),
                          )
                        ]),
                      ),
                    ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
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

  updatePlayerScore() {
    scoreUpdated = true;
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    int addToScore = numberCorrect;
    (settingsProvider.playerTurns == 2)
        ? addToScore = settingsProvider.p2Score + addToScore
        : addToScore = settingsProvider.p1Score + addToScore;
    setState(() {
      (settingsProvider.playerTurns == 2)
          ? Provider.of<SettingsProvider>(context, listen: false)
              .setP2Score(addToScore)
          : Provider.of<SettingsProvider>(context, listen: false)
              .setP1Score(addToScore);
    });
  }

  updatePlayerTurns() {
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.playerTurns == 2) {
      int playerTurns = settingsProvider.playerTurns + 1;
      Provider.of<SettingsProvider>(context, listen: false)
          .setPlayerTurns(playerTurns);
    } else {
      Provider.of<SettingsProvider>(context, listen: false).setPlayerTurns(1);
    }
  }

  updateRound() {
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.playerTurns == 4 &&
        settingsProvider.currentRound == settingsProvider.numberOfRounds) {
      debugPrint("End of Game");
    } else if (settingsProvider.playerTurns == 4 &&
        settingsProvider.currentRound != settingsProvider.numberOfRounds) {
      int currentRound = settingsProvider.currentRound + 1;
      Provider.of<SettingsProvider>(context, listen: false)
          .setCurrentRound(currentRound);
      updatePlayerTurns();
    } else {
      updatePlayerTurns();
    }
  }

  getFinalButtonTitle() {
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    String title;
    if (settingsProvider.playerTurns == 2) {
      title = "$player2 take your photos";
    } else if (settingsProvider.playerTurns == 4 &&
        settingsProvider.currentRound != settingsProvider.numberOfRounds) {
      title = 'Next Round';
    } else if (settingsProvider.currentRound ==
        settingsProvider.numberOfRounds) {
      title = 'New Game';
    } else {
      title = "Next";
    }
    return title;
  }

  Card buildCompareCard({
    required String p1Img,
    required File p1ImgPath,
    required File p2ImgPath,
    required bool same,
    required bool notSame,
  }) {
    return Card(
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 25, color: HexColor('#4b4272')),
              right: BorderSide(width: 20, color: HexColor('#afa6d6')),
              bottom: BorderSide(width: 25, color: HexColor('#4b4272')),
              left: BorderSide(width: 20, color: HexColor('#afa6d6'))),
          gradient: (Provider.of<SettingsProvider>(context, listen: false)
                      .playerTurns ==
                  2)
              ? LinearGradient(
                  colors: [
                    Color(Provider.of<SettingsProvider>(context, listen: false)
                        .p1ColorInt),
                    Color(Provider.of<SettingsProvider>(context, listen: false)
                        .p2ColorInt),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Color(Provider.of<SettingsProvider>(context, listen: false)
                        .p2ColorInt),
                    Color(Provider.of<SettingsProvider>(context, listen: false)
                        .p1ColorInt),
                  ],
                ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 3,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: AutoSizeText(
                  "Slide the white line left and right to compare the photos in this round.",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                      color: HexColor('#2d3a64')),
                  textAlign: TextAlign.center,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "Original",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 4,
                        color: HexColor('#2d3a64')),
                  ),
                  AutoSizeText(
                    "Match",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 4,
                        color: HexColor('#2d3a64')),
                  ),
                ],
              ),
            ),
            Stack(alignment: Alignment.center, children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2,
                    vertical: SizeConfig.blockSizeVertical * 1),
                child: SizedBox(
                  child: BeforeAfter(
                      beforeImage: Image(image: FileImage(p1ImgPath)),
                      afterImage: Image(
                        image: FileImage(p2ImgPath),
                      )),
                  //
                ),
              ),
              Visibility(
                visible: same,
                child: Positioned(
                    child: AvatarGlow(
                  endRadius: 180,
                  glowColor: Colors.green,
                  duration: const Duration(milliseconds: 3000),
                  repeat: true,
                  child: Image.asset(
                    'assets/images/Matched.png',
                    height: 250,
                  ),
                )),
              ),
              Visibility(
                visible: notSame,
                child: Positioned(
                    child: AvatarGlow(
                  endRadius: 180,
                  glowColor: Colors.red,
                  duration: const Duration(seconds: 3),
                  repeat: true,
                  child: Image.asset(
                    'assets/images/NoMatch.png',
                    height: 250,
                  ),
                )),
              )
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 3),
              child: AutoSizeText(
                "Are these pictures the same?",
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('6EB440'),
                        onPrimary: AppColor.textColor,
                        side: BorderSide(
                          color: AppColor.textColor,
                          width: 2,
                        )),
                    icon: ImageIcon(
                      const AssetImage("assets/images/CheckMark.png"),
                      size: SizeConfig.blockSizeHorizontal * 8,
                    ),
                    label: Text(
                      "YES!",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 8),
                    ),
                    onPressed: () {
                      switch (p1Img) {
                        case ("1st"):
                          toggleSame1();
                          break;
                        case ("2nd"):
                          toggleSame2();
                          break;
                        case ("3rd"):
                          toggleSame3();
                          break;
                        default:
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.lightBlue,
                        onPrimary: HexColor('#BF2C24'),
                        side: BorderSide(color: HexColor('#BF2C24'), width: 2)),
                    icon: ImageIcon(
                      const AssetImage("assets/images/NotTheSame.png"),
                      size: SizeConfig.blockSizeHorizontal * 8,
                    ),
                    label: Text(
                      "NO!",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 8),
                    ),
                    onPressed: () {
                      switch (p1Img) {
                        case ("1st"):
                          toggleNotSame1();
                          break;
                        case ("2nd"):
                          toggleNotSame2();
                          break;
                        case ("3rd"):
                          toggleNotSame3();
                          break;
                        default:
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
