// ignore_for_file: avoid_print

import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:provider/provider.dart';

import 'widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRouter, text: 'Dashboard', icon: Icons.compass_calibration_outlined, onPressed: () => navigateTo(Flurorouter.dashboardRouter)),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.tableRouter, text: 'Mesas', icon: Icons.deck_outlined, onPressed: () => navigateTo(Flurorouter.tableRouter)),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.productsRouter, text: 'Productos', icon: Icons.production_quantity_limits, onPressed: () => navigateTo(Flurorouter.productsRouter)),
          // MenuItem(text: 'Analytics', icon: Icons.show_chart_outlined, onPressed: () => print('Dashboard')),
          // MenuItem(text: 'Categories', icon: Icons.layers_outlined, onPressed: () => print('Dashboard')),
          // MenuItem(text: 'Discount', icon: Icons.attach_money_outlined, onPressed: () => print('Dashboard')),
          // MenuItem(text: 'Customers', icon: Icons.people_alt_outlined, onPressed: () => print('Dashboard')),
          
          const SizedBox(height: 40),
          const TextSeparator(text: 'UI elements'),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.iconsRouter, text: 'Icons', icon: Icons.list_alt_outlined, onPressed: () => navigateTo(Flurorouter.iconsRouter)),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRouter, text: 'Marketing', icon: Icons.mark_email_read_outlined, onPressed: () => print('Dashboard')),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRouter, text: 'Campaigns', icon: Icons.note_add_outlined, onPressed: () => print('Dashboard')),
          MenuItem(isActive: sideMenuProvider.currentPage == Flurorouter.blankRouter, text: 'Black', icon: Icons.post_add_outlined, onPressed: () => navigateTo(Flurorouter.blankRouter)),

          const SizedBox(height: 40),
          const TextSeparator(text: 'Exit'),
          MenuItem( text: 'Logout', icon: Icons.exit_to_app_outlined, onPressed: () => print('Dashboard')),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xff092044),
        Color(0xff092030),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10
      )
    ]
  );
}