import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambing_padula/add_kambing/models/kambing.dart';
import 'package:kambing_padula/testing/gallery_saver.dart';
import 'package:kambing_padula/testing/location.dart';
import 'package:kambing_padula/testing/qr_code.dart';
import 'add_kambing/kambing_list.dart';
import 'testing/localization.dart';
import 'testing/neumorphism.dart';
import 'testing/drawer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
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
              'Widgets',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    // color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const localize()));
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
                                  const SizedBox(height: 10.0),
                                  const Text("Easy",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 4.0),
                                  const Text("Localization",
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
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const gallerySaver()));
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
                                  const SizedBox(height: 10.0),
                                  const Text("Image",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 4.0),
                                  const Text("Save",
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
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const neumorphism()));
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
                                  const SizedBox(height: 10.0),
                                  const SizedBox(height: 4.0),
                                  const Text("Neumorphism",
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
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PDrawer()));
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
                                  const SizedBox(height: 10.0),
                                  const Text("kEwL",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 4.0),
                                  const Text("dRaWeR",
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
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocationPage()));
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
                                  const SizedBox(height: 10.0),
                                  const Text("User",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 4.0),
                                  const Text("Location",
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
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRCodePage()));
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
                                  const SizedBox(height: 10.0),
                                  const Text("QR",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 4.0),
                                  const Text("Code",
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
              ),
              const Spacer(),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const kambing_list()));
                  },
                  child: SizedBox(
                    width: 260.0,
                    height: 280.0,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset("assets/images/puteh.png",
                                  width: 128.0),
                              const SizedBox(height: 20.0),
                              Text("SENARAI",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34.0,
                                  ))),
                              const SizedBox(height: 3.0),
                              Text("KAMBING",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34.0,
                                  ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
