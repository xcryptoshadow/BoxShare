// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giga_share/models/user_model.dart';
import 'package:giga_share/screens/onboarding_screen.dart';
import 'package:giga_share/wiredash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Change to false to use live database instance.
const USE_DATABASE_EMULATOR = false;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
    (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) ? '10.0.2.2' : 'localhost';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDQTYz_Yxo3vgU5DRAn_BqeMAI28IfBMgY",
          authDomain: "right-share.firebaseapp.com",
          projectId: "right-share",
          databaseURL: "https://right-share-default-rtdb.firebaseio.com",
          storageBucket: "right-share.appspot.com",
          messagingSenderId: "159602786169",
          appId: "1:159602786169:web:a584484008e82d6d58f9a8",
          measurementId: "G-ZVWWT9G2Y9"),
    );
  } else {
    await Firebase.initializeApp();
  }

  //await Firebase.initializeApp();
  // final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user_model');

  if (USE_DATABASE_EMULATOR) {
    FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return WiredashApp(
      navigatorKey: navigatorKey,
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Giga Share',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryColor: Colors.blueAccent,
          cardTheme: const CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.blueAccent),
            elevation: 0,
          ),
        ),
        home: OnBoardingScreen(),
      ),
    );
  }
}
