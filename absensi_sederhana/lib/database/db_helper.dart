import 'package:absensi_sederhana/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

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
            username TEXT,
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
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    final db = await initDB();
    await db.insert('users', {
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    print("User Registrasi Success");
  }

  // --- CRUD KEHADIRAN ---

  // Create
  static Future<void> insertKehadiran(Kehadiran data) async {
    final db = await initDB();
    await db.insert(
      'kehadiran',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  static Future<List<Kehadiran>> getAllKehadiran() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('kehadiran');
    return List.generate(maps.length, (i) => Kehadiran.fromMap(maps[i]));
  }

  // Update
  static Future<void> updateKehadiran(Kehadiran data) async {
    final db = await initDB();
    await db.update(
      'kehadiran',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  // Delete
  static Future<void> deleteKehadiran(int id) async {
    final db = await initDB();
    await db.delete('kehadiran', where: 'id = ?', whereArgs: [id]);
  }
}
