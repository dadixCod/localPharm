import 'package:localpharm/backend/models/medicament.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }
    return _db;
  }

  Future<Database> initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'medicaments.db');

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) {
    db.execute(
      '''
        CREATE TABLE "medicament"(
          "id" INTEGER PRIMARY KEY AUTOINCREMENT,
          "name" TEXT NOT NULL,
          "imagePath" TEXT,
          "date" TEXT,
          "isExpired" INTEGER
        )
      ''',
    );
  }

  Future<int> addMedicament(Medicament medicament) async {
    Database? mydb = await db;
    return mydb!.transaction((txn) {
      return txn.insert(
        "medicament",
        medicament.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<int> updateMedicament(Medicament medicament) async {
    Database? mydb = await db;
    return mydb!.transaction((txn) {
      return txn.update(
        "medicament",
        medicament.toJson(),
        where: 'id = ?',
        whereArgs: [medicament.id],
      );
    });
  }

  Future<int> deleteMedicament(Medicament medicament) async {
    Database? mydb = await db;
    return mydb!.transaction((txn) {
      return txn.delete(
        "medicament",
        where: 'id = ?',
        whereArgs: [medicament.id],
      );
    });
  }

  Future<List<Medicament>> getAllTasks() async {
    Database? mydb = await db;
    final List<Map<String, dynamic>> data = await mydb!.query(
      "medicament",
      orderBy: 'ID DESC',
    );
    return List.generate(
        data.length, (index) => Medicament.fromJson(data[index]));
  }
}
