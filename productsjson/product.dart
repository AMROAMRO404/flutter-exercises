import 'dart:convert';
class Product{
  String productName;
  int quantity;
  double price;

  Product( {this.productName, this.quantity, this.price});
  factory Product.fromJson(dynamic jsonObject) {
    return Product(
      productName: jsonObject['productName'] as String,
      quantity: jsonObject['quantity'] as int,
      price: jsonObject['price'] as double,
    );
  }

  @override
  String toString() {
    return 'Product{productName: $productName, quantity: $quantity, price: $price}';
  }
}