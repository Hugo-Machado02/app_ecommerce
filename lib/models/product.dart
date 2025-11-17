import 'dart:io';
import 'package:app_ecommerce/database/product_helper.dart';

class Product {
  int? id;
  late String title;
  late String description;
  late double price;
  File? imageProduct;

  Product(
    this.title,
    this.description,
    this.price, {
    this.imageProduct,
    this.id,
  });

  Product.fromMap(Map map) {
    id = map[ProductHelper.idProduct];
    title = map[ProductHelper.titleProduct];
    description = map[ProductHelper.descriptionProduct];
    price = map[ProductHelper.priceProduct];
    imageProduct = map[ProductHelper.imageProduct] != null
        ? File(map[ProductHelper.imageProduct])
        : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      ProductHelper.idProduct: id,
      ProductHelper.titleProduct: title,
      ProductHelper.descriptionProduct: description,
      ProductHelper.priceProduct: price,
      ProductHelper.imageProduct: imageProduct?.path,
    };

    return map;
  }

  String get priceFormatted {
    return price.toStringAsFixed(2);
  }
}
