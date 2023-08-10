class BuysResponse {
  List<Buy> buys = [];

  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final buy = Buy(
          id: key,
          name: value["name"],
          price: value["price"],
          datesBuy: value["datesBuy"],
          created: value["created_at"]);
      buys.add(buy);
    });

    return buys;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    return Buy(
        id: json['id'],
        name: json["name"],
        price: json["price"],
        datesBuy: json["datesBuy"],
        created: "created_at");
  }
}

class Buy {
  String id;
  String name;
  String price;
  String datesBuy;
  String created;

  Buy({
    required this.id,
    required this.name,
    required this.price,
    required this.datesBuy,
    required this.created,
  });
}
