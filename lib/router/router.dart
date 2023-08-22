import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handler.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRouter = '/login';
  static String loginRouter = '/login';
  static String registerRouter = '/register';
  static String cardRouter = '/dashboard/card';
  static String blankRouter = '/dashboard/blank';
  static String tableRouter = '/dashboard/tables';
  static String categoriesRouter = '/dashboard/categories';
  static String productsRouter = '/dashboard/products';
  static String productsIDRouter = '/dashboard/product/:uid';
  static String newProductRouter = '/dashboard/newproduct';
  static String ordersRouter = '/dashboard/orders';
  static String salesRouter = '/dashboard/sales';
  static String salesTodayRouter = '/dashboard/salestoday';
  static String salesMonthRouter = '/dashboard/salesmonth';
  static String buyTodayRouter = '/dashboard/buytoday';
  static String buyMonthRouter = '/dashboard/buymonth';
  static String notesRouter = '/dashboard/notes';
  static String buysRouter = '/dashboard/buys';

  static void configureRoutes() {
    // Auth
    router.define(rootRouter,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRouter,
        handler: AdminHandlers.login, transitionType: TransitionType.fadeIn);
    router.define(registerRouter,
        handler: AdminHandlers.register, transitionType: TransitionType.fadeIn);

    // Dashboard
    router.define(tableRouter,
        handler: DashboardHandlers.table,
        transitionType: TransitionType.fadeIn);
    router.define(categoriesRouter,
        handler: DashboardHandlers.categories,
        transitionType: TransitionType.fadeIn);
    router.define(productsRouter,
        handler: DashboardHandlers.product,
        transitionType: TransitionType.fadeIn);
    router.define(productsIDRouter,
        handler: DashboardHandlers.productId,
        transitionType: TransitionType.fadeIn);
    router.define(newProductRouter,
        handler: DashboardHandlers.newProduct,
        transitionType: TransitionType.fadeIn);
    router.define(cardRouter,
        handler: DashboardHandlers.card, transitionType: TransitionType.fadeIn);
    router.define(notesRouter,
        handler: DashboardHandlers.notes,
        transitionType: TransitionType.fadeIn);
    router.define(ordersRouter,
        handler: DashboardHandlers.orders,
        transitionType: TransitionType.fadeIn);
    router.define(salesRouter,
        handler: DashboardHandlers.sales,
        transitionType: TransitionType.fadeIn);
    router.define(salesTodayRouter,
        handler: DashboardHandlers.salesToday,
        transitionType: TransitionType.fadeIn);
    router.define(salesMonthRouter,
        handler: DashboardHandlers.salesMonth,
        transitionType: TransitionType.fadeIn);
    router.define(buyTodayRouter,
        handler: DashboardHandlers.buyToday,
        transitionType: TransitionType.fadeIn);
    router.define(buyMonthRouter,
        handler: DashboardHandlers.buyMonth,
        transitionType: TransitionType.fadeIn);
    router.define(buysRouter,
        handler: DashboardHandlers.buys, transitionType: TransitionType.fadeIn);

    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
