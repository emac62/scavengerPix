import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';

import 'package:scavenger_hunt_pictures/settings_screen.dart';
import 'package:scavenger_hunt_pictures/widgets/color_arrays.dart';
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
                color: Colors.white,
                fontFamily: 'CaveatBrush',
                fontSize: SizeConfig.blockSizeHorizontal * 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.0),
          ),
          gradient: LinearGradient(colors: ColorArrays.purple),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info,
                      color: HexColor('#4b4272'),
                      size: SizeConfig.blockSizeHorizontal * 4,
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
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
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
                  "It’s scavenger hunt with a camera. Take photos and have your partner find them within set boundaries.",
                  style: TextStyle(
                    fontFamily: 'CaveatBrush',
                    fontSize: SizeConfig.blockSizeHorizontal * 6,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                child: Center(
                  child: PixButton(
                      name: "Start",
                      fontSize: SizeConfig.blockSizeHorizontal * 10,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                      }),
                ),
              )
            ]));
  }
}
