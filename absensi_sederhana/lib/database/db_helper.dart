import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'absensi.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            phone TEXT,
            password TEXT
          )''');
        await db.execute('''CREATE TABLE kehadiran (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            tanggal TEXT,
            keterangan TEXT
          )''');
      },
    );
  }

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    final db = await initDB();
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // --- USER REGISTER ---
  static Future<void> registerUser({
    required String name,

    required String email,
    required String phone,
    required String password,
  }) async {
    final db = await initDB();
    await db.insert('users', {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    print("User Registrasi Success");
  }



}


