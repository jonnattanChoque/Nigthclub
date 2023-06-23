import 'package:admin_dashboard/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Products? product;
  
  bool validateForm() {
    if(formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}