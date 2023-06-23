import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return ClipOval(
      child: GestureDetector(
        onTap: () => authProvider.logout(),
        child: SizedBox(
          width: 30,
          height: 30,
          child: Image.network('https://st4.depositphotos.com/9998432/22597/v/450/depositphotos_225976914-stock-illustration-person-gray-photo-placeholder-man.jpg'),
        ),
      ),
    );
  }
}