import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipOval(
              child: Image.asset('login-bg.png', width: 50, height: 50),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text('Night Drinks', style: GoogleFonts.montaguSlab(
                fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold
              ),),
            ),
          )
        ],
      ),
    );
  }
}