import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kambing_padula/main.dart';

class penjantan extends StatefulWidget {
  const penjantan({Key? key}) : super(key: key);

  @override
  State<penjantan> createState() => _penjantanState();
}

class _penjantanState extends State<penjantan> {
  bool isPressed = true;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final bgcolor =
        isDarkMode ? const Color(0xFF2E3239) : const Color(0xFFE7ECEF);
    Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
    double blur = isPressed ? 5 : 30;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
        title: Text(
          "Kambing Penjantan",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                // color: Colors.lightGreenAccent,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => isPressed = !isPressed),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: bgcolor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: blur,
                    offset: -distance,
                    color: isDarkMode ? Color(0xFF35393F) : Colors.white,
                    inset: isPressed,
                  ),
                  BoxShadow(
                    blurRadius: blur,
                    offset: distance,
                    color: isDarkMode ? Color(0xFF23262A) : Colors.grey,
                    inset: isPressed,
                  )
                ]),
            child: SizedBox(
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
