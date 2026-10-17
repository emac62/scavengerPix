import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:scavenger_hunt_pictures/main.dart';
import 'package:scavenger_hunt_pictures/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// AdHelper only supports Android and iOS ad unit IDs. The override must be
// cleared before the test body ends, so tests run through this wrapper.
void androidTest(String name, Future<void> Function(WidgetTester) body) {
  testWidgets(name, (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    try {
      await body(tester);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}

Future<void> loadFont(String family, String path) async {
  final bytes = await File(path).readAsBytes();
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.view(bytes.buffer)));
  await loader.load();
}

Future<void> pumpApp(WidgetTester tester) async {
  await tester.runAsync(() async {
    await loadFont('CaveatBrush', 'fonts/CaveatBrush-Regular.ttf');
    await loadFont('Roboto', 'fonts/Roboto-Regular.ttf');
  });
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SettingsProvider())],
      child: const ScavengerHuntPictures(),
    ),
  );
  await tester.pump();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'Match This!',
      packageName: 'test.app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          MethodChannel(
            'plugins.flutter.io/google_mobile_ads',
            StandardMethodCodec(AdMessageCodec()),
          ),
          (call) async => null,
        );
  });

  androidTest('intro page shows title and Start button', (tester) async {
    await pumpApp(tester);

    expect(find.text('Match This!'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });

  androidTest('info icon opens the about dialog', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byIcon(Icons.info));
    await tester.pumpAndSettle();

    expect(find.byType(AboutDialog), findsOneWidget);
  });

  androidTest('Start navigates to the settings screen', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Rounds'), findsOneWidget);
  });

  test('test device IDs are empty by default', () {
    expect(testDeviceIDs, isEmpty);
  });
}
