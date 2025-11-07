import 'dart:convert';

import 'package:aryanfront/Models/Data/Auth/User/dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Interfaces/istorage_service.dart';

class Storage implements IStorage {
  static final Storage _instance = Storage._internal();
  factory Storage() => _instance;
  Storage._internal();

  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_storage.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT UNIQUE,
            value TEXT
          )
        ''');
      },
    );
  }

  Future<void> _setValue(String key, String value) async {
    final db = await _database;
    await db.insert(
      'user_data',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> _getValue(String key) async {
    final db = await _database;
    final result =
    await db.query('user_data', where: 'key = ?', whereArgs: [key]);
    if (result.isNotEmpty) return result.first['value'] as String;
    return null;
  }

  @override
  Future<void> setUser(UserDto? user) async {
    if (user == null) {
      await _setValue('user', '');
    } else {
      await _setValue('user', jsonEncode(user.toJson()));
    }
  }

  @override
  Future<UserDto?> getUser() async {
    final value = await _getValue('user');
    if (value == null || value.isEmpty) return null;
    final Map<String, dynamic> map = jsonDecode(value);
    return UserDto.fromJson(map);
  }

  @override
  Future<void> setToken(String token) async => _setValue('token', token);

  @override
  Future<String?> getToken() async => _getValue('token');

  @override
  Future<void> clearAll() async {
    final db = await _database;
    await db.delete('user_data');
  }

  @override
  Future<String?> getDeviceToken() {
    // TODO: implement getDeviceToken
    throw UnimplementedError();
  }
}
