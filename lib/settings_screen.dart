import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/player1.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool keepScore = false;
  int p1Score = 0;
  int p2Score = 0;
  var rounds = 1;
  var roundsDisplay = "1";
  var player1 = "Player 1";
  var player2 = "Player 2";
  TextEditingController? roundsController;
  TextEditingController? p1Controller;
  TextEditingController? p2Controller;

  @override
  void initState() {
    super.initState();
    loadSettings().then((_) {
      roundsController = TextEditingController(text: roundsDisplay);
      p1Controller = TextEditingController(text: player1);
      p2Controller = TextEditingController(text: player2);
    });
  }

  loadSettings() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      rounds = (savedPref.getInt('numberOfRounds') ?? 1);
      keepScore = (savedPref.getBool('keepScore') ?? false);
      p1Score = (savedPref.getInt('p1Score') ?? 0);
      p2Score = (savedPref.getInt('p2Score') ?? 0);
      player1 = (savedPref.getString('player1') ?? "Player 1");
      player2 = (savedPref.getString('player2') ?? "Player 2");
    });
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
                fontSize: SizeConfig.blockSizeHorizontal * 15,
                letterSpacing: 2.0)),
        gradient:
            LinearGradient(colors: [HexColor('#9E9A75'), HexColor('#4A5E43')]),
        actions: const [],
      ),
      body: Center(
          child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3),
            child: AutoSizeText(
              "Rounds",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 8),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10),
            child: AutoSizeText(
              "One round consists of each player taking 3 pictures and comparing them. The number correct is given to the player that correctly matched the pictures.",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10,
                vertical: SizeConfig.blockSizeVertical * 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Number of Rounds:",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
                ),
                Flexible(
                  child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TextField(
                        controller: roundsController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          filled: true,
                          fillColor: HexColor("#4A5E43"),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        cursorColor: HexColor('#E7E6DC'),
                        style: TextStyle(
                            color: HexColor('#E7E6DC'),
                            fontSize: SizeConfig.blockSizeHorizontal * 6),
                        onChanged: (value) {
                          setState(() {
                            roundsDisplay = value;
                            rounds = int.tryParse(value) ?? 1;
                            settingsProvider.setNumberOfRounds(rounds);
                          });
                        },
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Keep Score?",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 8),
                ),
                Transform.scale(
                  scale: SizeConfig.blockSizeHorizontal * 0.2,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                    child: CupertinoSwitch(
                        value: keepScore,
                        activeColor: HexColor('#4A5E43'),
                        thumbColor: HexColor('#E7E6DC'),
                        onChanged: (value) {
                          setState(() {
                            keepScore = value;
                            settingsProvider.setKeepScore(keepScore);
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3),
            child: AutoSizeText(
              "Customize Names",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 8),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10,
                vertical: SizeConfig.blockSizeVertical * 1),
            child: TextField(
              controller: p1Controller,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                isCollapsed: true,
                border: UnderlineInputBorder(),
                hintText: "Enter Player 1's Name Here",
              ),
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 5,
                color: HexColor('#4A5E43'),
              ),
              onChanged: (value) {
                setState(() {
                  player1 = value;
                  settingsProvider.setPlayer1(player1);
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 10,
                vertical: SizeConfig.blockSizeVertical * 1),
            child: TextField(
              controller: p2Controller,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                isCollapsed: true,
                border: UnderlineInputBorder(),
                hintText: "Enter Player 2's Name Here",
              ),
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                  color: HexColor('#4A5E43')),
              onChanged: (value) {
                setState(() {
                  player2 = value;
                  settingsProvider.setPlayer2(player2);
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 15,
                vertical: SizeConfig.blockSizeVertical * 5),
            child: PixButton(
                name: "Play",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Player1Page()));
                },
                fontSize: SizeConfig.blockSizeHorizontal * 8),
          )
        ],
      )),
      bottomNavigationBar: Container(
        color: Colors.black26,
        child: const SizedBox(
          height: 60,
          child: Center(child: Text("Banner Ad")),
        ),
      ),
    );
  }
}
