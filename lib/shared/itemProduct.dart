import 'package:flutter/material.dart';
import 'package:app_ecommerce/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

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
          width: 60,
          height: 60,
          child: widget.product.imageProduct != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    widget.product.imageProduct!,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                )
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

        onTap: () async {
          const String phoneNumber = '+5564993411881';
          final String title = widget.product.title;
          final String price = "R\$ ${widget.product.priceFormatted}";
          final String message =
              "Olá! Tenho interesse no produto: $title, que custa $price. Gostaria de saber mais.";

          final Uri smsUri = Uri(
            scheme: 'sms',
            path: phoneNumber,
            query: 'body=$message',
          );

          try {
            await launchUrl(smsUri);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Erro ao abrir o aplicativo de SMS.",
                ),
              ),
            );
          }
        },
        onLongPress: widget.onLongPress,
      ),
    );
  }
}
