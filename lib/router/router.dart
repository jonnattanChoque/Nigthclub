
import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handler.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRouter = '/login';
  static String loginRouter = '/login';
  static String registerRouter = '/register';
  static String dashboardRouter = '/dashboard';
  static String iconsRouter = '/dashboard/icons';
  static String blankRouter = '/dashboard/blank';
  static String tableRouter = '/dashboard/tables';
  static String productsRouter = '/dashboard/products';
  static String productsIDRouter = '/dashboard/product/:uid';

  static void configureRoutes() {
    // Auth
    router.define(rootRouter, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRouter, handler: AdminHandlers.login, transitionType: TransitionType.fadeIn);
    router.define(registerRouter, handler: AdminHandlers.register, transitionType: TransitionType.fadeIn);

    // Dashboard
    router.define(dashboardRouter, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);
    router.define(iconsRouter, handler: DashboardHandlers.icons, transitionType: TransitionType.fadeIn);
    router.define(blankRouter, handler: DashboardHandlers.blank, transitionType: TransitionType.fadeIn);
    router.define(tableRouter, handler: DashboardHandlers.table, transitionType: TransitionType.fadeIn);
    router.define(productsRouter, handler: DashboardHandlers.product, transitionType: TransitionType.fadeIn);
    router.define(productsIDRouter, handler: DashboardHandlers.productId, transitionType: TransitionType.fadeIn);

    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}  