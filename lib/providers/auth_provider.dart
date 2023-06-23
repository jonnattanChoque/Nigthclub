import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/utils/authentication.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuth
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    FirebaseConn.signInWithEmailPassword(email, password).then((value) => {
      _token = value?.uid,
      // NotificationsService.showSnackBar("Usuario válido", false),
      LocalStorage.prefs.setString('token', _token!),
      authStatus = AuthStatus.authenticated,
      notifyListeners(),
      NavigationService.replaceTo(Flurorouter.dashboardRouter)
    }).onError((error, stackTrace) => {
      NotificationsService.showSnackBar('Error al hacer login, intente de nuevo', true)
    });
  }

  register(String email, String password) {
    FirebaseConn.registerWithEmailPassword(email, password).then((value) => {
      _token = value?.uid,
      // NotificationsService.showSnackBar("Usuario registrado", false),
      LocalStorage.prefs.setString('token', _token!),
      authStatus = AuthStatus.authenticated,
      notifyListeners(),
      NavigationService.replaceTo(Flurorouter.dashboardRouter)
    }).onError((error, stackTrace) => {
      NotificationsService.showSnackBar('Error al registrar, intente de nuevo', true)
    });
  }

  logout() {
    FirebaseConn.signOut().then((value) => {
      authStatus = AuthStatus.notAuth,
      LocalStorage.prefs.setString('token', ''),
      notifyListeners(),
      NavigationService.replaceTo(Flurorouter.loginRouter),
    });
  }

  Future<bool> isAuthenticated() async {
    if(LocalStorage.prefs.getString('token') == null || LocalStorage.prefs.getString('token') == '') {
      authStatus = AuthStatus.notAuth;
      notifyListeners();
      return false;
    } 

    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}