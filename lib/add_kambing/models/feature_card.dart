import 'package:flutter/material.dart';

import '../../testing/drawer.dart';
import '../../testing/gallery_saver.dart';
import '../../testing/localization.dart';
import '../../testing/location.dart';
import '../../testing/neumorphism.dart';
import '../../testing/qr_code.dart';
import '../../testing/video_player.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  final String title, image;

  @override
  Widget build(BuildContext context) {
    Function() onPressed = () {};
    var txtsty = TextStyle(color: Colors.white, fontSize: 20);
    if (title == 'Easy Localization') {
      onPressed = () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const localize()));
      };
    } else if (title == 'Image Saver') {
      onPressed = () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const gallerySaver()));
      };
    } else if (title == 'Neumorphism') {
      onPressed = () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const neumorphism()));
      };
      txtsty = TextStyle(color: Colors.white, fontSize: 18);
    } else if (title == 'Custom Drawer') {
      onPressed = () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const PDrawer()));
      };
    } else if (title == 'GPS') {
      onPressed = () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LocationPage()));
      };
    } else if (title == 'QR Code') {
      onPressed = () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QRCodePage()));
      };
    } else if (title == 'Video Player') {
      onPressed = () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VideoPage()));
      };
    }
    return MaterialButton(
      onPressed: onPressed,
      child: SizedBox(
        width: 140.0,
        height: 150.0,
        child: Card(
          color: Colors.transparent,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(image, width: 64.0),
                  const SizedBox(height: 10.0),
                  Wrap(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: txtsty,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
