import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/models/product.dart';

// burda veritabanı işlemleri yapılır
class DbHelper {
  Database? _db;
// burda veritabanını oluşturmak için kullanılırq
  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

// burda veritabanını oluşturmak için kullanılır
  initializeDb() async {
    String dbpath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbpath, version: 1, onCreate: createDb);
    return eTradeDb;
  }
// burda veritabanını oluşturmak için kullanılır
  void createDb(Database db, int version) async {
    await db.execute("Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

// burda veritabanından kayıt getirmek için kullanılır
  Future<List<Product>> getProducts() async {
    Database? db = await this.db;
    var result = await db!.query("products");
    return List.generate(
      result.length,
      (i) {
        return Product.fromObject(result[i]);
      },
    );
  }

  // burda veritabanına kayıt eklemek için kullanılır
  Future<int> insert(Product product) async {
    Database? db = await this.db;
    var result = await db!.insert("products", product.toMap());
    return result;
  }

// burda veritabanından kayıt silmek için kullanılır
  Future<int> delete(int id) async {
    Database? db = await this.db;
    var result = await db!.rawDelete("delete from products where id = $id");
    return result;
  }

// burda veritabanında kayıt güncellemek için kullanılır
  Future<int> update(Product product) async {
    Database? db = await this.db;
    var result = await db!.update("products", product.toMap(), where: "id = ?", whereArgs: [product.id]);
    return result;
  }
}
