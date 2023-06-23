
// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ApiHtttp {
  static final rtdb = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://myappflutter-58850-default-rtdb.firebaseio.com/');

  static Future httpGet(String base) async {
    final resp = await rtdb.ref().child(base).get();
    return resp.value;
  }

  static Future httpNewSingle(String base, Set<String> data) async {
    try {
      await rtdb.ref().child(base).set(data);
    } catch (e) {
      print(e);
      print('Error en el POST');
    }
  }

  static Future httpNew(String base, Map<String, dynamic> data) async {
    try {
      await rtdb.ref().child(base).set(data);
      return true;
    } catch (e) {
      print(e);
      print('Error en el POST');
    }
  }

  static Future httpUpdate(String base, Map<String, dynamic> data) async {
    try {
      await rtdb.ref().child(base).update(data);
      return true;
    } catch (e) {
      print(e);
      print('Error en el POST');
    }
  }

  static Future httpDelete(String base) async {
    try {
      await rtdb.ref().child(base).remove();
      return true;
    } catch (e) {
      print(e);
      print('Error en el DELETE');
    }
  }
}