import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambing_padula/add_kambing/models/kambing.dart';
import 'add_kambing/kambing_list.dart';
import 'testing/localization.dart';
import 'testing/neumorphism.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(KambingAdapter());
  await Hive.openBox<Kambing>('kambings');
  await EasyLocalization.ensureInitialized();
  runApp(
      // Naming based on country locale code 'https://www.fincher.org/Utilities/CountryLanguageList.shtml'
      EasyLocalization(
          supportedLocales: [Locale('en', 'US'), Locale('ms', 'MY')],
          path: 'assets/translations',
          fallbackLocale: Locale('en', 'US'),
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/goated.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Kambing Pak Dola',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  // color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  children: [
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => localize()));
                          },
                          child: SizedBox(
                            width: 140.0,
                            height: 150.0,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/goat_icon.png",
                                          width: 64.0),
                                      SizedBox(height: 10.0),
                                      Text("Easy",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(height: 4.0),
                                      Text("Localization",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () {},
                          child: SizedBox(
                            width: 140.0,
                            height: 150.0,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/puteh.png",
                                          width: 64.0),
                                      SizedBox(height: 10.0),
                                      Text("",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(height: 4.0),
                                      Text("",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  children: [
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => neumorphism()));
                          },
                          child: SizedBox(
                            width: 140.0,
                            height: 150.0,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/goat_icon.png",
                                          width: 64.0),
                                      SizedBox(height: 10.0),
                                      // Text("Neumorphism",
                                      //     style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 20.0,
                                      //     )),
                                      SizedBox(height: 4.0),
                                      Text("Neumorphism",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => kambing_list()));
                          },
                          child: SizedBox(
                            width: 140.0,
                            height: 150.0,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/puteh.png",
                                          width: 64.0),
                                      SizedBox(height: 10.0),
                                      Text("Senarai",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(height: 4.0),
                                      Text("Kambing",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
