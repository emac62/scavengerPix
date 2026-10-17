import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavenger_hunt_pictures/intro_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/widgets/material_color.dart';

const int maxFailedLoadAttempts = 3;

bool useTestAds = false;

List<String> testDeviceIDs = [
  "8f4cb8307ba6019ca82bccc419afe5d0", // my iPad
  "B148F45EC4D7035147769503E195ECF9", // Lenovo
  "f0e400f92fc1f762333ca805bd6291f2", // my iPhone
];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize().then((InitializationStatus status) {
    debugPrint('Initialization done: ${status.adapterStatuses}');
  });

  final RequestConfiguration requestConfiguration = RequestConfiguration(
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
      testDeviceIds: kReleaseMode ? const <String>[] : testDeviceIDs);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  final physSize = PlatformDispatcher.instance.views.first.physicalSize;

  final double deviceWidth = physSize.width;

  if (deviceWidth < 600) {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

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
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
    );
  }
}
