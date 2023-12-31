import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton({Key? key, 
  required this.onPressed, 
  required this.text, 
  required this.icon,
  this.isFilled = false, 
  this.color = Colors.indigo, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateProperty.all(color.withOpacity(0.9)),
        overlayColor: MaterialStateProperty.all(color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 18, 2, 2)),
          Text(text, style: const TextStyle(color: Color.fromARGB(255, 3, 0, 0)))
        ],
      ),
    );
  }
}