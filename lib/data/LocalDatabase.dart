import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:todo/data/NoteModel.dart';

class LocalDatabase {
  Database? database;
  String table_name = "notes_db";

  Future<Database> getDb() async {
    if (database == null) {
      database = await createDatabase();
      return database!;
    }
    return database!;
  }

  createDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = "${databasePath}notes.db";

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute(
        "CREATE TABLE $table_name(title text, description text, date text)");
  }

  //Add note
  Future addNote(Note note) async {
    Database db = await getDb();
    var id = await db.insert(table_name, note.toJson());
  }

  //Get notes
  Future<List> getAllNotes() async {
    Database db = await getDb();
    var result =
        await db.query(table_name, columns: ["title", "description", "date"]);

    return result.toList();
  }

  //Update note
  Future updateNote(Note note, String title) async {
    Database db = await getDb();
    var id = db.update(table_name, note.toJson(),
        where: "title=?", whereArgs: [title]);
  }

  //Delete note
  Future deleteNote(String title) async {
    Database db = await getDb();
    await db.delete(table_name, where: "title=?", whereArgs: [title]);
  }
}
