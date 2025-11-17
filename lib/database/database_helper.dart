import 'package:app_ecommerce/database/product_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  Future _onCreateDB(Database database, int version) async {
    await database.execute(ProductHelper.createTableproducts);
  }

  Future _onUpgradeDB(Database database, int oldVersion, int newVersion) async {
    await database.execute("DROP TABLE products");
    await _onCreateDB(database, newVersion);
  }

  Future<Database?> initDB() async {
    final pathDB = join(await getDatabasesPath(), 'productDatabase.db');

    try {
      return await openDatabase(
        pathDB,
        version: 1,
        onCreate: _onCreateDB,
        onUpgrade: _onUpgradeDB,
      );
    } catch (e) {
      print("Erro Database: $e");
    }
    return null;
  }
}
