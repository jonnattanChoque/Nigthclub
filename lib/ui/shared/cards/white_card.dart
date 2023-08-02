import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;

  const WhiteCard({Key? key, this.title, required this.child, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title != null)
            ...[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(title!, style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),),
              ),
              const Divider()
            ],
          child
        ],
      ),
    );
  }
}