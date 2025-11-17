import 'package:app_ecommerce/database/database_helper.dart';
import 'package:app_ecommerce/models/product.dart';
import 'package:app_ecommerce/persistence/image_persistence.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class ProductHelper {
  static final String nameTable = 'products';
  static final String idProduct = 'id';
  static final String titleProduct = 'title';
  static final String descriptionProduct = 'description';
  static final String priceProduct = 'price';
  static final String imageProduct = 'imageProduct';

  static get createTableproducts {
    return '''
      CREATE TABLE $nameTable(
        $idProduct INTEGER PRIMARY KEY AUTOINCREMENT,
        $titleProduct TEXT NOT NULL,
        $descriptionProduct TEXT NOT NULL,
        $priceProduct REAL NOT NULL,
        $imageProduct TEXT NULL
      )
    ''';
  }

  Future<List<Product>> getAllProducts() async {
    Database? db = await DatabaseHelper().database;
    List<Product> products = List.empty(growable: true);
    if (db != null) {
      List<Map> listProducts = await db.query(
        nameTable,
        columns: [
          idProduct,
          titleProduct,
          descriptionProduct,
          priceProduct,
          imageProduct,
        ],
      );

      for (Map productMap in listProducts) {
        products.add(Product.fromMap(productMap));
      }
    }
    return products;
  }

  Future<Product?> getProductById(int id) async {
    Database? db = await DatabaseHelper().database;
    if (db != null) {
      List<Map> product = await db.query(
        nameTable,
        columns: [
          idProduct,
          titleProduct,
          descriptionProduct,
          priceProduct,
          imageProduct,
        ],
        where: "id=?",
        whereArgs: [id],
      );

      return Product.fromMap(product.first);
    }
    return null;
  }

  Future<Product?> saveProduct(Product product) async {
    Database? db = await DatabaseHelper().database;
    if (db != null) {
      if (product.imageProduct != null) {
        String? savedImagePath = await FilePersistence().saveImageFile(
          product.imageProduct!,
        );
        if (savedImagePath != null) {
          product.imageProduct = File(savedImagePath);
        }
      }
      product.id = await db.insert(nameTable, product.toMap());
      return product;
    }
    return null;
  }

  Future<int?> editproduct(Product product) async {
    Database? db = await DatabaseHelper().database;
    if (db != null) {
      if (product.imageProduct != null) {
        String imagePath = product.imageProduct!.path;
        // Verifica se é uma imagem temporária (não está na pasta permanente)
        if (!imagePath.contains('product_images')) {
          String? savedImagePath = await FilePersistence().saveImageFile(
            product.imageProduct!,
          );
          if (savedImagePath != null) {
            product.imageProduct = File(savedImagePath);
          }
        }
      }
      return await db.update(
        nameTable,
        product.toMap(),
        where: "id=?",
        whereArgs: [product.id],
      );
    }
    return null;
  }

  Future<int?> deleteProduct(Product product) async {
    Database? db = await DatabaseHelper().database;
    if (db != null) {
      if (product.imageProduct != null) {
        await FilePersistence().deleteImageFile(product.imageProduct!.path);
      }
      return await db.delete(
        nameTable,
        where: '$idProduct = ?',
        whereArgs: [product.id],
      );
    }
    return null;
  }
}
