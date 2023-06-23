import 'package:admin_dashboard/ui/shared/buttons/link_text.dart';
import 'package:flutter/material.dart';

class CustomLinkBar extends StatelessWidget {
  const CustomLinkBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: (size.width > 1000) ? size.height * 0.05 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          // ignore: avoid_print
          LinkText(text: 'About', onPressed: () => print('about'),),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
          const LinkText(text: 'About'),
        ],
      ),
    );
  }
}