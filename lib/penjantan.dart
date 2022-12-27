import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kambing_padula/main.dart';

class penjantan extends StatefulWidget {
  const penjantan({Key? key}) : super(key: key);

  @override
  State<penjantan> createState() => _penjantanState();
}

class _penjantanState extends State<penjantan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/goated.jpg"),
              fit: BoxFit.cover)
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: new IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
              },
            ),
            title: Text("Kambing Penjantan",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),),),
            actions: [],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          )
      ),
    );
  }
}
