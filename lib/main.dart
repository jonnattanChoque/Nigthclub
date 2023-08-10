import 'package:admin_dashboard/providers/buys_provider.dart';
import 'package:admin_dashboard/providers/card_provider.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/providers/forms/card_form_provider.dart';
import 'package:admin_dashboard/providers/forms/product_form_provider.dart';
import 'package:admin_dashboard/providers/orders_provider.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/providers/sales_provider.dart';
import 'package:admin_dashboard/providers/tables_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDqN6zI4ImQ_nQXQj-845HLEe3-qcR0YaY",
          authDomain: "myappflutter-58850.firebaseapp.com",
          projectId: "myappflutter-58850",
          storageBucket: "myappflutter-58850.appspot.com",
          messagingSenderId: "714173052209",
          databaseURL:
              "https://myappflutter-58850-default-rtdb.firebaseio.com/",
          appId: "1:714173052209:web:4e2d8fd2f40b4e93092c10",
          measurementId: "G-70TM2N1PBT"));

  await LocalStorage.configurePreps();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => TablesProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => ProductsProvider()),
        ChangeNotifierProvider(
            lazy: true, create: (_) => ProductFormProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => OrdersProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => SalesProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => CardProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => CardFormProvider()),
        ChangeNotifierProvider(lazy: true, create: (_) => BuysProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Admin Night Drinks',
            initialRoute: Flurorouter.rootRouter,
            onGenerateRoute: Flurorouter.router.generator,
            navigatorKey: NavigationService.navigatorKey,
            scaffoldMessengerKey: NotificationsService.messageKey,
            builder: (_, child) {
              final authProvider = Provider.of<AuthProvider>(context);
              if (authProvider.authStatus == AuthStatus.checking) {
                return const SplashLayout();
              }

              if (authProvider.authStatus == AuthStatus.authenticated) {
                return DashBoardlayout(child: child!);
              } else {
                return AuthLayout(child: child!);
              }
            },
            theme: ThemeData(primarySwatch: Colors.amber),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
          );
        });
  }
}
