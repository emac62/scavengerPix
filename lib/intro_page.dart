import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
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
  getFontSize() {
    double fontSize = SizeConfig.isPhone
        ? SizeConfig.blockSizeVertical * 3.5
        : SizeConfig.isPort
            ? SizeConfig.blockSizeVertical * 4
            : SizeConfig.blockSizeVertical * 5.5;
    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    getFontSize();
    return Scaffold(
        appBar: GradientAppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Match This!",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'CaveatBrush',
                fontSize: SizeConfig.blockSizeVertical * 4,
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
                      size: SizeConfig.blockSizeHorizontal * 3.5,
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
                        const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Text(
                                  "Use the internal camera to play an active, cooperative scavenger hunt matching game with kids.",
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
                child: Column(
                  children: [
                    Text(
                      "An active picture scavenger hunt.",
                      style: TextStyle(
                        fontFamily: 'CaveatBrush',
                        fontSize: getFontSize(),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Set your boundaries, take photos and have your partner match them.",
                      style: TextStyle(
                        fontFamily: 'CaveatBrush',
                        fontSize: getFontSize(),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                child: Center(
                  child: PixButton(
                      name: "Start",
                      fontSize: getFontSize(),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                      }),
                ),
              )
            ]));
  }
}
