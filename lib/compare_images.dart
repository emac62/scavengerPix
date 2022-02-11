import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:scavenger_hunt_pictures/intro_page.dart';
import 'package:scavenger_hunt_pictures/player1.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class CompareImages extends StatefulWidget {
  final String firstImgPath;
  final String secondImgPath;
  final String thirdImgPath;
  final String fourthImgPath;
  final String fifthImgPath;
  final String sixthImgPath;

  const CompareImages(
      {Key? key,
      required this.firstImgPath,
      required this.secondImgPath,
      required this.thirdImgPath,
      required this.fourthImgPath,
      required this.fifthImgPath,
      required this.sixthImgPath})
      : super(key: key);

  @override
  _CompareImagesState createState() => _CompareImagesState();
}

class _CompareImagesState extends State<CompareImages> {
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

  toggleSame1() {
    setState(() {
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
      if (same3 == false) {
        same3 = !same3;
        numberCorrect += 1;
      } else {
        same3 = !same3;
        numberCorrect -= 1;
      }
      notSame3 = false;
      debugPrint('$numberCorrect');
    });
  }

  toggleNotSame1() {
    setState(() {
      if (same1 == true) {
        numberCorrect -= 1;
      }
      notSame1 = !notSame1;
      same1 = false;
    });
  }

  toggleNotSame2() {
    setState(() {
      if (same2 == true) {
        numberCorrect -= 1;
      }
      notSame2 = !notSame2;
      same2 = false;
    });
  }

  toggleNotSame3() {
    if (same3 == true) {
      numberCorrect -= 1;
    }
    setState(() {
      notSame3 = !notSame3;
      same3 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setVariables();
  }

  setVariables() async {
    firstImgPath = File(widget.firstImgPath);
    secondImgPath = File(widget.secondImgPath);
    thirdImgPath = File(widget.thirdImgPath);
    fourthImgPath = File(widget.fourthImgPath);
    fifthImgPath = File(widget.fifthImgPath);
    sixthImgPath = File(widget.sixthImgPath);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: AutoSizeText(
          "Compare Pics",
          style: TextStyle(
            color: HexColor('#E7E6DC'),
            fontFamily: 'CaveatBrush',
            fontSize: SizeConfig.blockSizeHorizontal * 10,
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
                child: Icon(
                  Icons.restart_alt,
                  color: HexColor('#E7E6DC'),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const IntroPage()));
                },
              )),
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
                    horizontal: SizeConfig.blockSizeVertical * 2,
                    vertical: SizeConfig.blockSizeVertical * 1),
                child: buildCompareCard(
                    p1Img: "1st",
                    p2Img: "4th",
                    p1ImgPath: firstImgPath!,
                    p2ImgPath: fourthImgPath!,
                    same: same1,
                    notSame: notSame1)),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeVertical * 2,
                    vertical: SizeConfig.blockSizeVertical * 1),
                child: buildCompareCard(
                    p1Img: "2nd",
                    p2Img: "5th",
                    p1ImgPath: secondImgPath!,
                    p2ImgPath: fifthImgPath!,
                    same: same2,
                    notSame: notSame2)),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeVertical * 2,
                    vertical: SizeConfig.blockSizeVertical * 1),
                child: buildCompareCard(
                    p1Img: "3rd",
                    p2Img: "6th",
                    p1ImgPath: thirdImgPath!,
                    p2ImgPath: sixthImgPath!,
                    same: same3,
                    notSame: notSame3)),
            numberCorrect == 0
                ? Card(
                    elevation: 4,
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 95,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeVertical * 3,
                              vertical: SizeConfig.blockSizeVertical * 2),
                          child: Text(
                            'Results',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeVertical * 3,
                              vertical: SizeConfig.blockSizeVertical * 2),
                          child: AutoSizeText(
                            "Click 'Yes' or 'No' for each pair of pix to get the results",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 6,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )
                : Card(
                    elevation: 4,
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 95,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeVertical * 3,
                              vertical: SizeConfig.blockSizeVertical * 2),
                          child: Text(
                            'Results',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeVertical * 3,
                              vertical: SizeConfig.blockSizeVertical * 2),
                          child: AutoSizeText(
                            "$numberCorrect correct!",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeVertical * 3,
                              vertical: SizeConfig.blockSizeVertical * 2),
                          child: PixButton(
                              name: "Switch Roles for Next Round",
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Player1Page()));
                              },
                              fontSize: SizeConfig.blockSizeHorizontal * 5),
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
        color: Colors.black26,
        child: const SizedBox(
          height: 60,
          child: Center(child: Text("Banner Ad")),
        ),
      ),
    );
  }

  Card buildCompareCard({
    required String p1Img,
    required String p2Img,
    required File p1ImgPath,
    required File p2ImgPath,
    required bool same,
    required bool notSame,
  }) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 3,
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: AutoSizeText(
                "Slide the white line left and right to compare the pix.",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5,
                    color: HexColor('#4A5E43')),
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Original $p1Img Pix",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                ),
                AutoSizeText(
                  "Matching $p2Img Pix",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                ),
              ],
            ),
          ),
          Stack(children: [
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
                  bottom: SizeConfig.blockSizeVertical * 5,
                  right: SizeConfig.blockSizeHorizontal * 5,
                  child: Image.asset('assets/images/CheckMark.png')),
            ),
            Visibility(
              visible: notSame,
              child: Positioned(
                  bottom: SizeConfig.blockSizeVertical * 5,
                  right: SizeConfig.blockSizeHorizontal * 5,
                  child: Image.asset('assets/images/NotTheSame.png')),
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
            padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PixButton(
                    name: "Yes",
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
                    fontSize: 16),
                PixButton(
                    name: "No",
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
                    fontSize: 16)
              ],
            ),
          )
        ],
      ),
    );
  }
}
