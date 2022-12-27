import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
      image: DecorationImage(
      image: AssetImage("images/kambir.jpg"),
      fit: BoxFit.cover)
      ),
    );
  }
}

