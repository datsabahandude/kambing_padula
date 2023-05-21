import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kambing_padula/add_kambing/models/feature_card.dart';
import 'package:kambing_padula/add_kambing/models/feature_list.dart';

import 'add_kambing/kambing_list.dart';

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
              SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featureList.length,
                    itemBuilder: (context, index) {
                      Feature feature = featureList[index];
                      return FeatureCard(
                          title: feature.title, image: feature.image);
                    }),
              ),
              const Spacer(),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const kambing_list())); // Use the correct class name for the destination screen
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
