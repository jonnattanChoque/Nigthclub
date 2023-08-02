class OrdersResponse {
  List<Orders> products = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = Orders(id: key, name: value["name"], price: value["price"], count: value["count"]);
      products.add(table);
    });

    return products;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final products = Orders(id: json["id"], name: json["name"], price: json["price"], count: json["count"]);
    return products;
  }
}

class Orders {
  String id;
  String name;
  String price;
  String count;

  Orders({
      required this.id,
      required this.name,
      required this.price,
      required this.count
  });

  Map toJson() => {
    'name': name,
    'price': price,
    'count': count,
  };
}