import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotPageFoundView extends StatelessWidget {
  const NotPageFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Esta página no existe', style: GoogleFonts.montserratAlternates(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black38
      )),
    );
  }
}