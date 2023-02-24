import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PDrawer extends StatefulWidget {
  const PDrawer({super.key});

  @override
  State<PDrawer> createState() => _PDrawerState();
}

class _PDrawerState extends State<PDrawer> {
  final _duration = const Duration(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const InkWell(
          onTap: _isDrawerTap,
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
            color: Colors.amber,
          ),
          AnimatedPositioned(
            left: 0,
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
              // child: ListView(children: []),
            ),
          )
        ],
      ),
    );
  }
}

void _isDrawerTap() {}
