import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavenger_hunt_pictures/intro_page.dart';

import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/widgets/material_color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SettingsProvider())],
      child: const ScavengerHuntPictures()));
}

class ScavengerHuntPictures extends StatelessWidget {
  const ScavengerHuntPictures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: HexColor('#E7E6DC'),
        fontFamily: 'CaveatBrush',
        primarySwatch: createMaterialColor(const Color(0xff4A5E43)),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: HexColor('#4A5E43'),
          displayColor: HexColor('#4A5E43'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
    );
  }
}
