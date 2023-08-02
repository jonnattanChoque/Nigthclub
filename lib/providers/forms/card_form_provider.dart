import 'package:admin_dashboard/models/card_model.dart';
import 'package:flutter/material.dart';

class CardFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CardValue? card;
  
  bool validateForm() {
    if(formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}