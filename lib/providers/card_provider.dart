import 'package:admin_dashboard/models/card_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier with BackService {
  List<CardValue> card = [];

  getCard() async {
    final json = await getData('bar/card');
    card = await CardResponse().jsonDecodes(json);
    notifyListeners();
  }

  newCard(String name) async {
    final data = { "name": name };
    final response = await newData(data, 'bar/card', null);
    final newTable = await CardResponse().jsonDecodes(response);
    if(newTable != null) {
      card.add(newTable);
      getCard();
      return true;
    } else {
      return false;
    }
  }

  updateCard(String name, String id) async {
    final data = { "name": name };
    final response = await updateData(data, 'bar/card/$id');
    if(response != null) {
      return true;
    } else {
      return false;
    }
  }
}