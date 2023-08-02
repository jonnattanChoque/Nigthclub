import 'package:flutter/material.dart';

class BackgroundAuth extends StatelessWidget {
  const BackgroundAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('logo.png'),
          fit: BoxFit.cover
        )
      );
  }
}