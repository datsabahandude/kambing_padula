import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambing_padula/add_kambing/models/kambing.dart';
import 'add_kambing/kambing_list.dart';

// import 'package:awesome_notifications/awesome_notifications.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AwesomeNotifications().initialize(
  //     "resource://drawable/puteh",
  //     [
  //       NotificationChannel(
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic Notification',
  //           channelDescription: 'Channel Description')
  //     ],
  //     debug: true);
  await Hive.initFlutter();
  Hive.registerAdapter(KambingAdapter());
  await Hive.openBox<Kambing>('kambings');
  await EasyLocalization.ensureInitialized();
  runApp(
      // Naming based on country locale code 'https://www.fincher.org/Utilities/CountryLanguageList.shtml'
      EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('ms', 'MY')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/goated.jpg"), context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Kambing Pak Dola',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const kambing_list(),
    );
  }
}
