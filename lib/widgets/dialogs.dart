import 'package:flutter/material.dart';
import 'package:scavenger_hunt_pictures/player1.dart';

showPlayer1Instructions(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Original Pics"),
    content: const Text(
        "Use the camera to take close up pictures within the set boundaries. Once completed, click the 'Next' button and pass to your competitor."),
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
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Matching Pics"),
    content: const Text(
        "Click on 'Match this picture:' to see the original image. Try to find that item within the set boundaries and take exactly the same picture. Click 'Next' when finished."),
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
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Player1Page()));
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Restart the Game?"),
    content: const Text("Restarting the game will remove the Original Pics."),
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
