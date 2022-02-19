import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
          color: HexColor('#93c521')),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Original Pics",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Text(
      "Use the camera to take close up pictures within the set boundaries. Once completed, click the 'Next' button and pass to your competitor.",
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
          color: HexColor('#93c521')),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Matching Pics",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Text(
      "Click on 'Match this picture:' to see the original image. Try to find that item within the set boundaries and take exactly the same picture. Click 'Next' when finished.",
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
          color: HexColor('#93c521')),
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
    title: Text(
      "Restart the Game?",
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 8,
          color: AppColor.textColor),
    ),
    content: Text(
      "Restarting the game will remove the Original Pics.",
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
