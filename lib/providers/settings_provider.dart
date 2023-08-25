import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late String _player1;
  late String _player2;
  late bool _keepScore;
  late int _numberOfRounds;
  late int _numberOfPictures;
  late int _p1Score;
  late int _p2Score;
  late int _currentRound;
  late int _playerTurns;
  late int _p1ColorInt;
  late int _p2ColorInt;

  SettingsProvider() {
    _player1 = "Player 1";
    _player2 = "Player 2";
    _keepScore = false;
    _numberOfRounds = 2;
    _numberOfPictures = 1;
    _p1Score = 0;
    _p2Score = 0;
    _currentRound = 1;
    _playerTurns = 1;
    _p1ColorInt = 4280391411;
    _p2ColorInt = 4294961979;

    loadPreferences();
  }

  String get player1 => _player1;
  String get player2 => _player2;
  bool get keepScore => _keepScore;
  int get numberOfRounds => _numberOfRounds;
  int get numberOfPictures => _numberOfPictures;
  int get p1Score => _p1Score;
  int get p2Score => _p2Score;
  int get currentRound => _currentRound;
  int get playerTurns => _playerTurns;
  int get p1ColorInt => _p1ColorInt;
  int get p2ColorInt => _p2ColorInt;

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
  }

  void setNumberOfRounds(int numberOfRounds) {
    _numberOfRounds = numberOfRounds;
    notifyListeners();
  }

  void setNumberOfPictures(int numberOfPictures) {
    _numberOfPictures = numberOfPictures;
    notifyListeners();
  }

  void setCurrentRound(int currentRound) {
    _currentRound = currentRound;
    notifyListeners();
  }

  void setP1Score(int p1Score) {
    _p1Score = p1Score;
    notifyListeners();
  }

  void setP2Score(int p2Score) {
    _p2Score = p2Score;
    notifyListeners();
  }

  void setPlayerTurns(int playerTurns) {
    _playerTurns = playerTurns;
    notifyListeners();
  }

  void setP1ColorInt(int p1ColorInt) {
    _p1ColorInt = p1ColorInt;
    savePreferences();
    notifyListeners();
  }

  void setP2ColorInt(int p2ColorInt) {
    _p2ColorInt = p2ColorInt;
    savePreferences();
    notifyListeners();
  }

  void resetPlayers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('player1');
    prefs.remove('player2');

    notifyListeners();
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("player1", _player1);
    prefs.setString("player2", _player2);
    prefs.setInt("p1ColorInt", _p1ColorInt);
    prefs.setInt("p2ColorInt", _p2ColorInt);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? player1 = prefs.getString("player1");
    String? player2 = prefs.getString("player2");
    int? p1ColorInt = prefs.getInt("p1ColorInt");
    int? p2ColorInt = prefs.getInt("p2ColorInt");

    if (player1 != null) setPlayer1(player1);
    if (player2 != null) setPlayer2(player2);
    if (p1ColorInt != null) setP1ColorInt(p1ColorInt);
    if (p2ColorInt != null) setP2ColorInt(p2ColorInt);
  }
}
