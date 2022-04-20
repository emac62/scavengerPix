// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/original_pictures.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
// ignore: unused_import
import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';
import 'package:scavenger_hunt_pictures/widgets/banner_ad_widget.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/player_color_picker.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool keepScore = false;
  var player1;
  var player2;
  BannerAdContainer bannerAdContainer = const BannerAdContainer();

  TextEditingController? p1Controller;
  TextEditingController? p2Controller;

  @override
  void initState() {
    super.initState();
    loadSettings().then((_) {
      p1Controller = TextEditingController(text: player1);
      p2Controller = TextEditingController(text: player2);
    });
  }

  loadSettings() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      player1 = (savedPref.getString('player1') ?? "");
      player2 = (savedPref.getString('player2') ?? "");
    });
  }

  @override
  void dispose() {
    super.dispose();
    p1Controller!.dispose();
    p2Controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: AutoSizeText("Settings",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 10,
                color: HexColor('#fefefe'),
                letterSpacing: 2.0)),
        gradient: LinearGradient(colors: ColorArrays.purple),
        actions: const [],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: AutoSizeText(
              "Rounds",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 7),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10),
            child: AutoSizeText(
              "A single round consists of each player taking photos and matching photos.",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomSlidingSegmentedControl(
                radius: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: ColorArrays.orangeYellow)),
                children: {
                  1: Text(
                    "1",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  ),
                  2: Text(
                    "2",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  ),
                  3: Text(
                    "3",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  )
                },
                onValueChanged: (int value) {
                  setState(() {
                    Provider.of<SettingsProvider>(context, listen: false)
                        .setNumberOfRounds(value);
                  });
                },
                initialValue: settingsProvider.numberOfRounds,
                fixedWidth: SizeConfig.blockSizeHorizontal * 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: AutoSizeText(
              "Photos per Round",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 7),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10),
            child: AutoSizeText(
              "Choose the number of photos to be taken before matching them.",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomSlidingSegmentedControl(
                radius: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: ColorArrays.whiteBlue)),
                children: {
                  1: Text(
                    "1",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  ),
                  2: Text(
                    "2",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  ),
                  3: Text(
                    "3",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  )
                },
                onValueChanged: (int value) {
                  setState(() {
                    Provider.of<SettingsProvider>(context, listen: false)
                        .setNumberOfPictures(value);
                  });
                },
                initialValue: settingsProvider.numberOfPictures,
                fixedWidth: SizeConfig.blockSizeHorizontal * 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Keep Score?",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 7),
                ),
                Transform.scale(
                  scale: SizeConfig.blockSizeHorizontal * 0.2,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        right: SizeConfig.blockSizeHorizontal * 5),
                    child: CupertinoSwitch(
                        value: keepScore,
                        activeColor: HexColor('#f0a142'),
                        thumbColor: HexColor('#fefefe'),
                        trackColor: HexColor('#71a4db'),
                        onChanged: (value) {
                          setState(() {
                            keepScore = value;
                            Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .setKeepScore(keepScore);
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 10, 0,
                SizeConfig.blockSizeHorizontal * 10, 10),
            child: AutoSizeText(
              "A point is awarded and tallied for each correct match.",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: AutoSizeText(
              "Add Names",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 7),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10),
            child: AutoSizeText(
              "Enter name and choose canvas background.",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                top: SizeConfig.blockSizeVertical * 2,
                bottom: SizeConfig.blockSizeVertical * 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    controller: p1Controller,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter Player 1's Name",
                        hintStyle: TextStyle(color: HexColor('#bb8b1f'))),
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    onChanged: (value) async {
                      if (value == "") {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove('player1');
                      } else {
                        Provider.of<SettingsProvider>(context, listen: false)
                            .setPlayer1(value);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: PlayerColorPicker(
                    onSelectColor: (color) {
                      String p1ColorString = color.value.toString();
                      int value = int.parse(p1ColorString);
                      Provider.of<SettingsProvider>(context, listen: false)
                          .setP1ColorInt(value);
                    },
                    availableColors: const [
                      Colors.yellow,
                      Colors.blue,
                      Colors.orange,
                      Colors.green,
                    ],
                    initialColor: Color(
                        Provider.of<SettingsProvider>(context, listen: false)
                            .p1ColorInt),
                    player: settingsProvider.player1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                top: SizeConfig.blockSizeVertical * 1,
                bottom: SizeConfig.blockSizeVertical * 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    controller: p2Controller,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter Player 2's Name",
                        hintStyle: TextStyle(color: HexColor('#bb8b1f'))),
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    onChanged: (value) async {
                      if (value == "") {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove('player2');
                      } else {
                        Provider.of<SettingsProvider>(context, listen: false)
                            .setPlayer2(value);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: PlayerColorPicker(
                    onSelectColor: (color) {
                      String p2ColorString = color.value.toString();
                      int value = int.parse(p2ColorString);
                      Provider.of<SettingsProvider>(context, listen: false)
                          .setP2ColorInt(value);
                    },
                    availableColors: const [
                      Colors.yellow,
                      Colors.blue,
                      Colors.orange,
                      Colors.green,
                    ],
                    initialColor: Color(
                        Provider.of<SettingsProvider>(context, listen: false)
                            .p2ColorInt),
                    player: settingsProvider.player2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 2),
            child: PixButton(
                name: "Let's Play!",
                onPressed: () {
                  int turn = 1;
                  setState(() {
                    Provider.of<SettingsProvider>(context, listen: false)
                        .setPlayerTurns(turn);
                    Provider.of<SettingsProvider>(context, listen: false)
                        .setCurrentRound(turn);
                    Provider.of<SettingsProvider>(context, listen: false)
                        .setP1Score(0);
                    Provider.of<SettingsProvider>(context, listen: false)
                        .setP2Score(0);
                  });

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OriginalPage()));
                },
                fontSize: SizeConfig.blockSizeHorizontal * 7),
          )
        ],
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
