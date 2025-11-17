import 'package:app_ecommerce/database/product_helper.dart';
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
  List<Product> _products = List<Product>.empty(growable: true);
  String _notification = "";

  ProductHelper helperProduct = ProductHelper();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    helperProduct.getAllProducts().then((data) {
      setState(() {
        _products = data;
      });
    });
  }

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
            onDismissed: (direction) async {
              int? deleteProduct = await helperProduct.deleteProduct(
                productItem,
              );
              _notification = "Erro! Exclusão do Produto não realizado!";
              setState(() {
                if (deleteProduct != null) {
                  _products.remove(productItem);
                  _notification = "Exclusão do Produto realizado!";

                  SnackBar snackBar = SnackBar(
                    content: Text(_notification),
                    backgroundColor: Colors.redAccent[100],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
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
                int? editProductDB = await helperProduct.editproduct(
                  editProduct,
                );
                _notification = "Erro! Edição do Produto não realizado!";

                setState(() {
                  if (editProductDB != null) {
                    _notification = "Edição do Produto realizado!";
                    _products.remove(productItem);
                    _products.insert(position, editProduct);
                  }

                  SnackBar snackBar = SnackBar(
                    content: Text(_notification),
                    backgroundColor: Colors.blueAccent[100],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
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
          Product? saveProductDB = await helperProduct.saveProduct(newProduct);
          _notification = "Erro! Cadastro do Produto não realizado!";

          setState(() {
            if (saveProductDB != null) {
              _notification = "Cadastro do Produto realizado!";
              _products.add(newProduct);
            }

            SnackBar snackBar = SnackBar(
              content: Text(_notification),
              backgroundColor: Colors.greenAccent,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
