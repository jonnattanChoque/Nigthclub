import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/product_id_view.dart';
import 'package:admin_dashboard/ui/views/product_view.dart';
import 'package:admin_dashboard/ui/views/tables_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentpageUrl(Flurorouter.dashboardRouter);
    if(authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  static Handler icons = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentpageUrl(Flurorouter.iconsRouter);
    if(authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

  static Handler blank = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentpageUrl(Flurorouter.blankRouter);
    if(authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });
  
  static Handler table = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentpageUrl(Flurorouter.tableRouter);
    if(authProvider.authStatus == AuthStatus.authenticated) {
      return const TablesView();
    } else {
      return const LoginView();
    }
  });

  static Handler product = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentpageUrl(Flurorouter.productsRouter);
    if(authProvider.authStatus == AuthStatus.authenticated) {
      return const ProductView();
    } else {
      return const LoginView();
    }
  });

  static Handler productId = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentpageUrl(Flurorouter.productsIDRouter);
    if(authProvider.authStatus == AuthStatus.authenticated) {
      if(params['uid']?.first != null) {
        final uid = params['uid']!.first;
        return ProductIDView(uid: uid);
      } else {
        return const ProductView();
      }
    } else {
      return const LoginView();
    }
  });
}