import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tima/models/user.dart';

class DBProvider {
  //Singelton method -JP
  DBProvider._privateConstructor();
  static final DBProvider instance = DBProvider._privateConstructor();
  //get database if exists, otherwise create with initDB -JP
  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TiMaDB.db");
    return await openDatabase(
      path,
      version: 2,
      //onOpen: (db) {},
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE User (
          id INTEGER PRIMARY KEY,
          name TEXT,
          office TEXT,
          weeklyhours INTEGER,
          persnr INTEGER,
          aktiv INTERGER NOT NULL DEFAULT 0
          )''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // if (newVersion > oldVersion) {
    //already moved to _onCreate -JP(31.12.2021)
    //   await db.execute('''
    //     ALTER TABLE User ADD COLUMN aktiv INTERGER NOT NULL DEFAULT 0
    //   ''');
    // }
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var res = await db.query("User", orderBy: 'id');
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> newUser(User newUser) async {
    Database db = await instance.database;
    return await db.insert('User', newUser.toMap());
  }

  Future<void> setUserAktiv(int? id) async {
    //execute funktion only then id > 0
    if (id! > 0) {
      Database db = await instance.database;
      //set all users with aktiv = 1 to inaktiv
      await db.execute('UPDATE User SET aktiv = 0 WHERE aktiv = 1');
      //set the entered/required user to aktiv
      await db.execute('UPDATE User SET aktiv = 1 WHERE id = $id ');
    }
  }

  Future<void> deleteUser(int? id) async {
    //execute funktion only then id > 0
    if (id! > 0) {
      Database db = await instance.database;
      await db.delete('User', where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<int> updateUser(User newUser) async {
    Database db = await instance.database;
    return await db.update('User', newUser.toMap(),
        where: "id = ?", whereArgs: [newUser.id]);
  }

  Future<User?> getUser(int id) async {
    Database db = await instance.database;
    var res = await db.query('User', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<User> getAktivUser() async {
    Database db = await instance.database;
    var res = await db.query('User', where: 'aktiv = 1');
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    } else {
      //return default User, if no aktiv user in database found!
      return User(
          name: 'Max Mustermann',
          office: 'Hamburg',
          weeklyhours: 35,
          persnr: 00011122,
          aktiv: 1);
    }
  }

  //useful funktion for clearing the user table -JP(31.12.2021)
  // Future<void> deleteAllUsers() async {
  //   Database db = await instance.database;
  //   await db.rawDelete("Delete * from User");
  // }
}
