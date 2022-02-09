import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  late String _player1;
  late String _player2;
  late String _img1;
  late String _img2;
  late String _img3;
  late String _img4;
  late String _img5;
  late String _img6;

  SettingsProvider() {
    _player1 = "Player 1";
    _player2 = "Player 2";
    _img1 = "";
    _img2 = "";
    _img3 = "";
    _img4 = "";
    _img5 = "";
    _img6 = "";
    loadPreferences();
  }

  String get player1 => _player1;
  String get player2 => _player2;
  String get img1 => _img1;
  String get img2 => _img2;
  String get img3 => _img3;
  String get img4 => _img4;
  String get img5 => _img5;
  String get img6 => _img6;

  void setPlayer1(String player1) {
    _player1 = player1;
    notifyListeners();
    savePreferences();
  }

  void setPlayer2(String player2) {
    _player2 = player2;
    notifyListeners();
    savePreferences();
  }

  void setImg1(String img1) {
    _img1 = img1;
    notifyListeners();
    savePreferences();
  }

  void setImg2(String img2) {
    _img2 = img2;
    notifyListeners();
    savePreferences();
  }

  void setImg3(String img3) {
    _img3 = img3;
    notifyListeners();
    savePreferences();
  }

  void setImg4(String img4) {
    _img4 = img4;
    notifyListeners();
    savePreferences();
  }

  void setImg5(String img5) {
    _img5 = img5;
    notifyListeners();
    savePreferences();
  }

  void setImg6(String img6) {
    _img6 = img6;
    notifyListeners();
    savePreferences();
  }

  clearImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("player1", _player1);
    prefs.setString("player2", _player2);
    prefs.setString("img1", _img1);
    prefs.setString("img2", _img2);
    prefs.setString("img3", _img3);
    prefs.setString("img4", _img4);
    prefs.setString("img5", _img5);
    prefs.setString("img6", _img6);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? player1 = prefs.getString("player1");
    String? player2 = prefs.getString("player2");
    String? img1 = prefs.getString("img1");
    String? img2 = prefs.getString("img2");
    String? img3 = prefs.getString("img3");
    String? img4 = prefs.getString("img4");
    String? img5 = prefs.getString("img5");
    String? img6 = prefs.getString("img6");

    if (player1 != null) setPlayer1(player1);
    if (player2 != null) setPlayer2(player2);
    if (img1 != null) setImg1(img1);
    if (img2 != null) setImg2(img2);
    if (img3 != null) setImg3(img3);
    if (img4 != null) setImg4(img4);
    if (img5 != null) setImg5(img5);
    if (img6 != null) setImg6(img6);
  }

  // encodes bytes list as string
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // decode bytes from a string
  static imageFrom64BaseString(String base64String) {
    final UriData? data = Uri.parse(base64String).data;
    return data!.contentAsBytes();
  }
}
