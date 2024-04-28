import 'package:mobile_assignment_1/core/models/user_info/user_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async {
  final path = join(await getDatabasesPath(), 'user_database.db');
  return openDatabase(path, onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, email TEXT, studentId TEXT, level INTEGER, password TEXT)',
    );
  }, version: 1);
}
class LocalDatabase {
  static late Database _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'user_database.db');
    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, email TEXT, studentId TEXT, level INTEGER, password TEXT)',
      );
    }, version: 1);
  }

  static Future<void> insertUser( user) async {
    final Database db = await database;
    await db.insert('users', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateUser( user) async {
    final Database db = await database;
    await db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<void> deleteUser(int id) async {
    final Database db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
