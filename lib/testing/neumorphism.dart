import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepage.dart';

class neumorphism extends StatefulWidget {
  const neumorphism({Key? key}) : super(key: key);

  @override
  State<neumorphism> createState() => _neumorphismState();
}

class _neumorphismState extends State<neumorphism> {
  bool isPressed = true;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final bgcolor =
        isDarkMode ? const Color(0xFF2E3239) : const Color(0xFFE7ECEF);
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(28, 28);
    double blur = isPressed ? 5 : 30;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
        ),
        title: Text(
          "Neumorphism",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                // color: Colors.lightGreenAccent,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
        // actions: [],
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
                    color: isDarkMode ? const Color(0xFF35393F) : Colors.white,
                    inset: isPressed,
                  ),
                  BoxShadow(
                    blurRadius: blur,
                    offset: distance,
                    color: isDarkMode ? const Color(0xFF23262A) : Colors.grey,
                    inset: isPressed,
                  )
                ]),
            child: const SizedBox(
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
