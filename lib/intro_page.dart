import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';

import 'package:scavenger_hunt_pictures/settings_screen.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: NewGradientAppBar(
          automaticallyImplyLeading: false,
          title: AutoSizeText(
            "Match This!",
            style: TextStyle(
                color: HexColor('#2d3a64'),
                fontFamily: 'CaveatBrush',
                fontSize: SizeConfig.blockSizeHorizontal * 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.0),
          ),
          gradient: LinearGradient(colors: [
            HexColor('#d5ebf6'),
            HexColor('#8f76af'),
            HexColor('#d5ebf6'),
          ]),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info,
                      color: HexColor('#8f76af'),
                    ),
                  ),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset(
                        'assets/images/SHPLogo.png',
                        height: 50,
                        width: 50,
                      ),
                      applicationName: "Match This!",
                      applicationVersion: "1.0.1",
                      applicationLegalese: '©2022 borderlineBoomer',
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: const [
                                Text(
                                  "Use the device's camera to play a scavenger hunt matching game with kids.",
                                ),
                              ],
                            ))
                      ],
                    );
                  }),
            )
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/SHPLogo.png",
                height: SizeConfig.blockSizeVertical * 25,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 4),
                child: Text(
                  "Play scavenger hunt with the camera. Alternate taking and finding pictures within boundaries.",
                  style: TextStyle(
                    fontFamily: 'CaveatBrush',
                    fontSize: SizeConfig.blockSizeHorizontal * 6,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              PixButton(
                  name: "Start",
                  fontSize: SizeConfig.blockSizeHorizontal * 10,
                  onPressed: () {
                    debugPrint(
                        'Intro start playerTurns: ${Provider.of<SettingsProvider>(context, listen: false).playerTurns}');
                    debugPrint(
                        'Intro start player1: ${Provider.of<SettingsProvider>(context, listen: false).player1}');
                    debugPrint(
                        'Intro start player2: ${Provider.of<SettingsProvider>(context, listen: false).player2}');
                    int num = imageCache!.currentSize;
                    debugPrint("Cache: $num");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
                  })
            ]));
  }
}
