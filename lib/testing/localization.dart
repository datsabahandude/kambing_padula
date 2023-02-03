import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class localize extends StatefulWidget {
  const localize({Key? key}) : super(key: key);

  @override
  State<localize> createState() => _localizeState();
}

class _localizeState extends State<localize> {
  @override
  Widget build(BuildContext context) {
    // LanguageController controller = context.read<LanguageController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'lingua',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                // color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ).tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "text_example",
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                      // color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ).tr(),
            ),
            TextButton(
              child: const Text(
                "en",
              ).tr(),
              onPressed: () {
                context.setLocale(const Locale('en', 'US'));
                // controller.onLanguageChanged();
              },
            ),
            TextButton(
              child: const Text(
                "my",
              ).tr(),
              onPressed: () {
                context.setLocale(const Locale('ms', 'MY'));
                // controller.onLanguageChanged();
              },
            )
          ],
        ),
      ),
    );
  }
}
