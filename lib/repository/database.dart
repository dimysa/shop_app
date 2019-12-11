import 'package:sqflite/sqflite.dart';
import 'package:myapp/models/address_info.dart';
import 'package:path/path.dart';

class DataRepository {
  static final DataRepository _repository = DataRepository._();
  Database _db;
  
  factory DataRepository() {
    return _repository;
  }

  DataRepository._();  

  Future<Database> get database async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'myapp.db');
    // deleteDatabase(path);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE AddressInfo (id INTEGER PRIMARY KEY AUTOINCREMENT, address TEXT, name TEXT, phone TEXT, comment TEXT)');
      },
    );
    return db;
  }

  Future<int> insertAddress(AddressInfo addressInfo) async {
    final db = await database;
    final res = db.insert('AddressInfo', addressInfo.toMap());
    return res;
  }

  Future<List<AddressInfo>> getAddresses() async {
    final db = await database;
    var res = await db.query('AddressInfo');
    var list = res.isNotEmpty ? res.map((x) => AddressInfo.fromMap(x)).toList() : <AddressInfo>[];
    return list;
  }

  Future<AddressInfo> getAdressesById(int id) async {
    final db = await database;
    var res = await db.query('AddressInfo', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? AddressInfo.fromMap(res.first) : null;
  }
}
