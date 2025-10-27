import 'package:flutter/material.dart';
import 'package:app_ecommerce/models/product.dart';

class Itemproduct extends StatefulWidget {
  final Product product;
  final String imageUrl = "images/sem_foto.jpg";
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
        leading: Image(image: AssetImage(widget.imageUrl)),
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
