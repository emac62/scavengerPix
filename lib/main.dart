import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavenger_hunt_pictures/intro_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/widgets/material_color.dart';

const int maxFailedLoadAttempts = 3;

List<String> testDeviceIDs = [
  "F8D0842E69D7D08FBA97DE652D059DEA", //Pixel 4
  "8E3C44E0453B296DEDFBA106CDBB59CC", // Samsung S5
  "B23BF33B20AC43239D05001A504F0EF3", //iPhone8 13.0
  "77D59CAC6A854490B6A389C9B5531A12", //iPhone13 mini 15.0
  "ea230aa9edfec099faea521e541b8502", //my phone
  "98729598294fd9d76c953d7d056f902c",
  "4520409bc3ffb536b6e203bf9d0b0007", //old SE
  "8f4cb8307ba6019ca82bccc419afe5d0", // my iPad
];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize().then((InitializationStatus status) {
    debugPrint('Initialization done: ${status.adapterStatuses}');
  });

  final RequestConfiguration requestConfiguration = RequestConfiguration(
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
      testDeviceIds: testDeviceIDs);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
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
        scaffoldBackgroundColor: HexColor('#a7d8f6'),
        fontFamily: 'CaveatBrush',
        primarySwatch: createMaterialColor(const Color(0xff4b4272)),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: HexColor('#4b4272'),
          displayColor: HexColor('#4b4272'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
    );
  }
}
