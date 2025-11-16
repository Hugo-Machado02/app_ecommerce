import 'package:flutter/material.dart';
import 'package:app_ecommerce/models/product.dart';

class Itemproduct extends StatefulWidget {
  final Product product;
  final VoidCallback? onLongPress;

  const Itemproduct({super.key, required this.product, this.onLongPress});

  @override
  State<Itemproduct> createState() => _ItemproductState();
}

class _ItemproductState extends State<Itemproduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(0),
          width: 60,
          height: 60,
          child: widget.product.imageProduct != null
              ? Image.file(widget.product.imageProduct!, fit: BoxFit.cover)
              : Icon(Icons.hide_image, size: 40),
        ),
        title: Text(
          widget.product.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          widget.product.description,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        ),
        trailing: Text(
          "R\$ ${widget.product.priceFormatted.toString().replaceAll(".", ",")}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
        onTap: () {},
        onLongPress: widget.onLongPress,
      ),
    );
  }
}
