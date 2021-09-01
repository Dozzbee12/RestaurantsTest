

class ResturantModel {
  int productID = 0;
  String productName = "";
  String category = "";
  int price = 0;

  ResturantModel({required this.productID, required this.productName, required this.category, required this.price});

  ResturantModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'] ;
    productName = json['productName'];
    category = json['category'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['category'] = this.category;
    data['price'] = this.price;
    return data;
  }
  
}