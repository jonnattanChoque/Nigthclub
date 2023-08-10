import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/buys_view.dart';
import 'package:admin_dashboard/ui/views/card_view.dart';
import 'package:admin_dashboard/ui/views/category_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/new_product_view.dart';
import 'package:admin_dashboard/ui/views/note_view.dart';
import 'package:admin_dashboard/ui/views/product_id_view.dart';
import 'package:admin_dashboard/ui/views/product_view.dart';
import 'package:admin_dashboard/ui/views/sales_month_view.dart';
import 'package:admin_dashboard/ui/views/sales_today_view.dart';
import 'package:admin_dashboard/ui/views/sales_view.dart';
import 'package:admin_dashboard/ui/views/tables_view.dart';
import 'package:admin_dashboard/utils/buys/orders.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler blank = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.blankRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });

  static Handler table = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.tableRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const TablesView();
    } else {
      return const LoginView();
    }
  });

  static Handler categories = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.categoriesRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CategoriesView();
    } else {
      return const LoginView();
    }
  });

  static Handler product = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.productsRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ProductView();
    } else {
      return const LoginView();
    }
  });

  static Handler productId = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.productsIDRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) {
        final uid = params['uid']!.first;
        return ProductIDView(uid: uid);
      } else {
        return const ProductView();
      }
    } else {
      return const LoginView();
    }
  });

  static Handler newProduct = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.newProductRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const NewProductView();
    } else {
      return const LoginView();
    }
  });

  static Handler card = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.cardRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CardView();
    } else {
      return const LoginView();
    }
  });

  static Handler orders = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.ordersRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const OrdersView();
    } else {
      return const LoginView();
    }
  });

  static Handler sales = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.salesRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const SalesView();
    } else {
      return const LoginView();
    }
  });

  static Handler salesToday = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.salesTodayRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const SalesTodayView();
    } else {
      return const LoginView();
    }
  });

  static Handler salesMonth = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.salesMonthRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const SalesMonthView();
    } else {
      return const LoginView();
    }
  });

  static Handler notes = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.notesRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const NotesView();
    } else {
      return const LoginView();
    }
  });

  static Handler buys = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentpageUrl(Flurorouter.buysRouter);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BuysView();
    } else {
      return const LoginView();
    }
  });
}
