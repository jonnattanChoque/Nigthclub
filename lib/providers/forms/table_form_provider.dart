import 'package:flutter/material.dart';

class TableFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  
  bool validateForm() {
    if(formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}