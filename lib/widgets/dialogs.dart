import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:scavenger_hunt_pictures/settings_screen.dart';
import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

showPlayer1Instructions(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 6,
          color: Colors.green[700]),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: HexColor('#a7d8f6'),
    title: Text(
      "Original Pics",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Text(
      "Click on the camera icon to take close up pictures within the set boundaries. Once completed, click the 'Next' button and pass to your competitor.",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 4,
          color: AppColor.textColor),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showPlayer2Instructions(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 6,
          color: Colors.green[700]),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: HexColor('#a7d8f6'),
    title: Text(
      "Match This!",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Text(
      "Click on 'Match This' to see the original image. Try to find that item within the set boundaries and take exactly the same photo. Click 'Next' when finished.",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 4,
          color: AppColor.textColor),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

restartGame(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 6,
          color: Colors.green[700]),
    ),
    onPressed: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SettingsScreen()));
    },
  );

  Widget cancelButton = TextButton(
    child: Padding(
      padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
      child: Text(
        "Cancel",
        style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 6,
            color: AppColor.orangeRed),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: HexColor('#a7d8f6'),
    title: Text(
      "Restart the Game?",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Text(
      "Restarting the game will delete all photos taken.",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 4,
          color: AppColor.textColor),
    ),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showScore(BuildContext context, String player1, String player2, int p1Score,
    int p2Score) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 6,
          color: Colors.green[700]),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    titlePadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 15,
        vertical: SizeConfig.blockSizeVertical * 5),
    actionsPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 3,
        vertical: SizeConfig.blockSizeVertical * 2),
    backgroundColor: HexColor('#a7d8f6'),
    shape: Border(
        top: BorderSide(width: 25, color: HexColor('#ffffa6')),
        right: BorderSide(width: 20, color: HexColor('#f0a142')),
        bottom: BorderSide(width: 25, color: HexColor('#f0a142')),
        left: BorderSide(width: 20, color: HexColor('#ffffa6'))),
    elevation: 10,
    title: Text(
      "Updated Score",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$player1  - $p1Score",
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 6,
              color: Color(Provider.of<SettingsProvider>(context, listen: false)
                  .p1ColorInt)),
        ),
        Text(
          "$player2 - $p2Score",
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 6,
              color: Color(Provider.of<SettingsProvider>(context, listen: false)
                  .p2ColorInt)),
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
