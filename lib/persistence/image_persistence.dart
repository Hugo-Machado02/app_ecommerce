import 'dart:convert';
import 'dart:io';
import 'package:app_ecommerce/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FilePersistence {
  Future<File> _getDirImage() async {
    final path = (await getApplicationDocumentsDirectory()).path;
    File localImage = File("$path/images_products.json");
    if (localImage.existsSync()) {
      return localImage;
    } else {
      return localImage.create(recursive: true);
    }
  }

  Future<String?> saveImageFile(File imageFile) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/product_images');

      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';
      final savedImage = await imageFile.copy('${imagesDir.path}/$fileName');

      return savedImage.path;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteImageFile(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future saveImage(List<Product> products) async {
    File localImage = await _getDirImage();
    List mapProducts = [];

    for (Product product in products) {
      mapProducts.add(product.toMap());
    }

    String value = json.encode(mapProducts);
    return localImage.writeAsStringSync(value);
  }

  Future<List<Product>> readData() async {
    File localImage = await _getDirImage();
    List<Product> products = [];

    String value = await localImage.readAsStringSync();
    List mapValue = json.decode(value);

    for (var value in mapValue) {
      products.add(Product.fromMap(value));
    }

    return products;
  }
}
