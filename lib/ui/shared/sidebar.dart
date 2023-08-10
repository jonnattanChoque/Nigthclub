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
          const TextSeparator(text: 'Administración'),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.categoriesRouter,
              text: 'Categorias',
              icon: Icons.category_outlined,
              onPressed: () => navigateTo(Flurorouter.categoriesRouter)),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.productsRouter,
              text: 'Productos',
              icon: Icons.production_quantity_limits,
              onPressed: () => navigateTo(Flurorouter.productsRouter)),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.tableRouter,
              text: 'Mesas',
              icon: Icons.deck_outlined,
              onPressed: () => navigateTo(Flurorouter.tableRouter)),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.cardRouter,
              text: 'Tarjeta',
              icon: Icons.card_membership_outlined,
              onPressed: () => navigateTo(Flurorouter.cardRouter)),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.notesRouter,
              text: 'Notas',
              icon: Icons.today_outlined,
              onPressed: () => navigateTo(Flurorouter.notesRouter)),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.buysRouter,
              text: 'Compras',
              icon: Icons.monetization_on_outlined,
              onPressed: () => navigateTo(Flurorouter.buysRouter)),
          const SizedBox(height: 40),
          const TextSeparator(text: 'Pedidos'),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.ordersRouter,
              text: 'Ordenes',
              icon: Icons.money_outlined,
              onPressed: () => navigateTo(Flurorouter.ordersRouter)),
          const SizedBox(height: 40),
          const TextSeparator(text: 'Reportes'),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.salesRouter,
              text: 'Total',
              icon: Icons.today_outlined,
              onPressed: () => navigateTo(Flurorouter.salesRouter)),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.salesTodayRouter,
              text: 'Diaría',
              icon: Icons.today_outlined,
              onPressed: () => navigateTo(Flurorouter.salesTodayRouter)),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.salesMonthRouter,
              text: 'Mensual',
              icon: Icons.today_outlined,
              onPressed: () => navigateTo(Flurorouter.salesMonthRouter)),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 166, 4, 131),
        Color.fromARGB(255, 112, 5, 89),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
