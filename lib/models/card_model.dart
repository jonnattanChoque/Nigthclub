class CardResponse {
  List<CardValue> card = [];

  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final category = CardValue(id: key, name: value["name"], date: value["created_at"]);
      card.add(category);
    });

    return card;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final category = CardValue(id: json['id'], name: json["name"], date: "null");
    return category;
  }
}

class CardValue {
  String id;
  String name;
  String date;

  CardValue({
      required this.id,
      required this.name,
      required this.date,
  });
}