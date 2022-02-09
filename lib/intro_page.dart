import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:scavenger_hunt_pictures/player1.dart';
import 'package:scavenger_hunt_pictures/widgets/pix_button.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: NewGradientAppBar(
          automaticallyImplyLeading: false,
          title: AutoSizeText(
            "Scavenger Pix",
            style: TextStyle(
                color: HexColor('#E7E6DC'),
                fontFamily: 'CaveatBrush',
                fontSize: SizeConfig.blockSizeHorizontal * 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.0),
          ),
          gradient: LinearGradient(
              colors: [HexColor('#9E9A75'), HexColor('#4A5E43')]),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info,
                      color: HexColor('#E7E6DC'),
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
                      applicationName: "Scavenger Hunt Pictures",
                      applicationVersion: "1.1.1",
                      applicationLegalese: '©2022 borderlineBoomer',
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Text(
                                  "Use the device's camera to play a scavenger hunt game with kids.",
                                  style: TextStyle(color: HexColor('#4A5E43')),
                                ),
                              ],
                            ))
                      ],
                    );
                  }),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          color: HexColor('#E7E6DC'),
          child: Column(
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
                    '''Play scavenger hunt with the camera. Alternate taking and finding pictures within boundaries.  
                    ''',
                    style: TextStyle(
                      color: HexColor('#4A5E43'),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Player1Page()));
                    })
              ]),
        ));
  }
}
