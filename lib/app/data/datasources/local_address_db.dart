import 'package:maps_app/app/data/models/address.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _tableName = 'addresses';

class LocalAddressDB {
  Database? _database;

  Future<LocalAddressDB> initDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'address.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table $_tableName (
            id integer primary key autoincrement, cep text, addressLine text,
            number integer, additionalInfo text, lat real, lng real
          )
        ''');
      },
    );

    return this;
  }

  Future<int> insert(Address address) async {
    final db = _database!;
    return await db.insert(_tableName, address.toDBMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Address>> getAll() async {
    final db = _database!;
    final result = await db.query(_tableName);

    return result.map((map) => Address.fromDBMap(map)).toList();
  }

  Future<int> update(int id, Address address) async {
    final db = _database!;
    return await db.update(
      _tableName,
      address.toDBMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = _database!;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
