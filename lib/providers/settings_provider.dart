import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  late String _player1;
  late String _player2;
  late bool _keepScore;
  late int _numberOfRounds;
  late int _p1Score;
  late int _p2Score;
  late int _currentRound;

  SettingsProvider() {
    _player1 = "Player 1";
    _player2 = "Player 2";
    _keepScore = false;
    _numberOfRounds = 1;
    _p1Score = 0;
    _p2Score = 0;
    _currentRound = 1;

    loadPreferences();
  }

  String get player1 => _player1;
  String get player2 => _player2;
  bool get keepScore => _keepScore;
  int get numberOfRounds => _numberOfRounds;
  int get p1Score => _p1Score;
  int get p2Score => _p2Score;
  int get currentRound => _currentRound;

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

  void setKeepScore(bool keepScore) {
    _keepScore = keepScore;
    notifyListeners();
    savePreferences();
  }

  void setNumberOfRounds(int numberOfRounds) {
    _numberOfRounds = numberOfRounds;
    notifyListeners();
    savePreferences();
  }

  void setCurrentRound(int currentRound) {
    _currentRound = _currentRound;
    notifyListeners();
    savePreferences();
  }

  void setP1Score(int p1Score) {
    _p1Score = p1Score;
    notifyListeners();
    savePreferences();
  }

  void setP2Score(int p2Score) {
    _p2Score = p2Score;
    notifyListeners();
    savePreferences();
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("player1", _player1);
    prefs.setString("player2", _player2);
    prefs.setBool('keepScore', _keepScore);
    prefs.setInt('numberOfRounds', _numberOfRounds);
    prefs.setInt('p1Score', _p1Score);
    prefs.setInt('p2Score', _p2Score);
    prefs.setInt('currentRound', _currentRound);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? player1 = prefs.getString("player1");
    String? player2 = prefs.getString("player2");
    bool? keepScore = prefs.getBool("keepScore");
    int? numberOfRounds = prefs.getInt("numberOfRounds");
    int? p1Score = prefs.getInt("p1Score");
    int? p2Score = prefs.getInt("p2Score");
    int? currentRound = prefs.getInt('currentRound');

    if (player1 != null) setPlayer1(player1);
    if (player2 != null) setPlayer2(player2);
    if (keepScore != null) setKeepScore(keepScore);
    if (numberOfRounds != null) setNumberOfRounds(numberOfRounds);
    if (p1Score != null) setP1Score(p1Score);
    if (p2Score != null) setP2Score(p2Score);
    if (currentRound != null) setCurrentRound(currentRound);
  }
}
