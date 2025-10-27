import 'package:app_ecommerce/products_operation.dart';
import 'package:flutter/material.dart';
import 'package:app_ecommerce/models/product.dart';
import 'package:app_ecommerce/shared/itemProduct.dart';

class productsList extends StatefulWidget {
  const productsList({super.key});

  @override
  State<productsList> createState() => _productsListState();
}

class _productsListState extends State<productsList> {
  List<Product> _products = [
    Product(
      title: "Mouse",
      description: "Mouse Gamer RGB Logitech para jogos FPS",
      price: 180.00,
    ),
    Product(
      title: "Teclado",
      description: "Teclado Attack Shark K86 - Mecanico",
      price: 320.00,
    ),
    Product(
      title: "Headset",
      description: "Headset Pichau - Emulado 7.1 - RGB",
      price: 250.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Produtos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.greenAccent[700],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, position) {
          Product productItem = _products[position];

          return Dismissible(
            key: ValueKey(productItem.id),
            background: Container(
              color: Colors.redAccent[200],
              child: Align(
                alignment: Alignment(-0.9, 0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                _products.removeAt(position);
              });
            },
            child: Itemproduct(
              product: productItem,
              onLongPress: () async {
                Product editProduct = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        productOperation(product: productItem),
                  ),
                );
                if (editProduct != null) {
                  setState(() {
                    _products.removeAt(position);
                    _products.insert(position, editProduct);
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[700],
        onPressed: () async {
          Product newProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => productOperation()),
          );
          setState(() {
            _products.add(newProduct);
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
