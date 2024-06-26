import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/deck.dart';
import '../models/flashcard.dart';

class DBHelper {
  static const String _databaseName = 'flashcards.db';
  static const int _databaseVersion = 1;
  Database? _database;

  DBHelper._();
  static final DBHelper _singleton = DBHelper._();
  factory DBHelper() => _singleton;
  get db async {
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    var dbDir = await getApplicationDocumentsDirectory();
    var dbPath = path.join(dbDir.path, _databaseName);

    // open the database
    var db = await openDatabase(dbPath, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE deck(
            id INTEGER PRIMARY KEY,
            title TEXT
          )
        ''');

      await db.execute('''
          CREATE TABLE card(
            id INTEGER PRIMARY KEY,
            question TEXT,
            answer TEXT,
            deck_id INTEGER,
            FOREIGN KEY (deck_id) REFERENCES deck(id)
          )
        ''');
    });

    return db;
  }

  Future<List<Deck>> initFromFileJson(String fileName) async {
    var response = await rootBundle.loadString(fileName);
    final data = (await json.decode(response)) as List;
    List<Deck> decks = [];
    for (int i = 0; i < data.length; i++) {
      Deck deck = Deck(createdAt: DateTime.now(), title: data[i]["title"]);
      await deck.dbSave();
      final cs = data[i]["flashcards"] as List;
      for (int j = 0; j < cs.length; j++) {
        FlashCard card = FlashCard(
          createdAt: DateTime.now(),
          deckId: deck.id!,
          question: cs[j]["question"],
          answer: cs[j]["answer"],
        );
        await card.dbSave();
      }
      decks.add(deck);
    }

    return decks;
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where}) async {
    final db = await this.db;
    return where == null ? db.query(table) : db.query(table, where: where);
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await this.db;
    int id = await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<void> update(String table, Map<String, dynamic> data) async {
    final db = await this.db;
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<void> delete(String table, int id) async {
    final db = await this.db;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
