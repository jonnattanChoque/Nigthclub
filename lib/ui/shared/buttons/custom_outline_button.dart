import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlineButton({Key? key, 
  required this.onPressed, 
  required this.text, 
  this.color = Colors.blue, 
  this.isFilled = false,
  this.isTextWhite = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: color)
        ),
        backgroundColor: MaterialStateProperty.all(
          isFilled ? color.withOpacity(0.4) : Colors.transparent
        )
      ),
      onPressed: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(text, style: TextStyle(fontSize: 16, color: isTextWhite ? const Color.fromARGB(255, 2, 0, 0) : color)),
      ),
    );
  }
}