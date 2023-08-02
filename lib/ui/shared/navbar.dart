import 'package:admin_dashboard/main.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/widgets/navbar_avatar.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Navbar extends StatelessWidget {
   const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if(size.width <= 700)
            IconButton(onPressed: () => SideMenuProvider.openMenu(), icon: const Icon(Icons.menu_outlined)),
          const SizedBox(width: 5),
          DigitalClock(
            is24HourTimeFormat: false,
            hourMinuteDigitTextStyle: Theme.of(context)
                .textTheme
                .headlineMedium!,
            secondDigitTextStyle: Theme.of(context)
                .textTheme
                .bodySmall!,
            colon: Text(
              ":",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: MyApp.themeNotifier.value == ThemeMode.light 
              ? const Icon(Icons.dark_mode, color: Colors.black,) 
              : const Icon(Icons.light_mode, color: Colors.yellow,),
            onPressed: () {
              MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            }
          ),
          const NavbarAvatar(),
          const SizedBox(width: 20)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Colors.transparent,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(31, 95, 93, 93),
        blurRadius: 5
      )
    ]
  );
}