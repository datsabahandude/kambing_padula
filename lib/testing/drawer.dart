import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PDrawer extends StatefulWidget {
  const PDrawer({super.key});

  @override
  State<PDrawer> createState() => _PDrawerState();
}

class _PDrawerState extends State<PDrawer> {
  final _duration = const Duration(milliseconds: 1000);
  bool isDrawer = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            setState(() {
              isDrawer = !isDrawer;
            });
          },
          child: Icon(Icons.list),
        ),
        centerTitle: true,
        title: Text(
          "Kewl dRaWeR",
          style: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.amber[50],
          ),
          AnimatedPositioned(
            left: isDrawer ? 0 : -300,
            duration: _duration,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      spreadRadius: 10.0,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Container(
                height: height,
                width: width * 0.4,
                color: Colors.blueGrey,
              ),
              // child: ListView(children: [Text('data1'), Text('data2')]),
            ),
          )
        ],
      ),
    );
  }
}
