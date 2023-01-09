import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:kambing_padula/add_kambing/kambing.dart';
import 'add_kambing/kambing_list.dart';
import 'penjantan.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(KambingAdapter());
  await Hive.openBox<Kambing>('kambings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Kambing Pak Dola'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/goated.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
         /*actions: [
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => penjantan()));
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("images/kambir.jpg"),
                backgroundColor: Colors.transparent,
              ),
            ),

          ],*/
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  print("Hello World");
                },
                child: Text("Hello World")),
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
                                    builder: (context) => penjantan()));
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
                                      Image.asset("images/goat_icon.png",
                                          width: 64.0),
                                      SizedBox(height: 10.0),
                                      Text("Kambing",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(height: 4.0),
                                      Text("Penjantan",
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
                                      Image.asset("images/puteh.png",
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
