import 'dart:io';
import 'package:flutter/material.dart';

class Product {
  int? _id;
  late String _title;
  late String _description;
  late double _price;
  File? _imageProduct;

  Product(this._title, this._description, this._price, this._imageProduct);

  Product.fromMap(Map map) {
    this._id = map['id'];
    this._description = map['description'];
    this._price = map['price'];
    this._imageProduct = map['imageProduct'] != ""
        ? File(map['imageProduct'])
        : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': _title,
      'description': _description,
      'price': _price,
      'imageProduct': _imageProduct != null ? _imageProduct!.path : "",
    };

    return map;
  }

  int? get id {
    return _id;
  }

  String get title {
    return _title;
  }

  set title(String title) {
    _title = title;
  }

  String get description {
    return _description;
  }

  set description(String description) {
    _description = description;
  }

  double get price {
    return _price;
  }

  String get priceFormatted {
    return _price.toStringAsFixed(2);
  }

  set price(double price) {
    _price = price;
  }

  File? get imageProduct {
    return _imageProduct;
  }

  set imageProduct(File? imageProduct) {
    _imageProduct = imageProduct;
  }

  String toString() {
    return "Product(id: $_id, title: $_title, description: $_description, price: $_price, imageProduct: $_imageProduct)";
  }
}
