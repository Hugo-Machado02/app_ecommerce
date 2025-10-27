import 'package:uuid/uuid.dart';

const Uuid _idGenerator = Uuid();

class Product {
  final String _id;
  String _title;
  String _description;
  double _price;

  Product({
    required String title,
    required String description,
    required double price,
  }) : _id = _idGenerator.v4(),
       _title = title,
       _description = description,
       _price = price;

  String get id {
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
}
