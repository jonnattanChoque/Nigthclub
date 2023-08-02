class ProductResponse {
  List<Products> products = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = Products(id: key, name: value["name"], price: value["price"], date: value["created_at"], image: value["image"], category: value["category"]);
      products.add(table);
    });

    return products;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final products = Products(
      id: json['id'], 
      name: json["name"], 
      price: json["price"], 
      date: "null", 
      image: json["image"], 
      category: json["category"]
    );
    return products;
  }
}

class Products {
  String id;
  String name;
  String price;
  String date;
  String image;
  String category;

  Products({
      required this.id,
      required this.name,
      required this.price,
      required this.date,
      required this.image,
      required this.category
  });
}