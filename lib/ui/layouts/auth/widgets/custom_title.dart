import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('twitter-white-logo.png', width: 50, height: 50),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.contain,
            child: Text('Happening Now', style: GoogleFonts.montaguSlab(
              fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
    );
  }
}