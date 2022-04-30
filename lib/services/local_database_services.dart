import 'package:movies_test/models/favourites_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _localDatabaseService =
      LocalDatabaseService._initialization();

  LocalDatabaseService._initialization() {
    print("initialized");
  }

  factory LocalDatabaseService() {
    return _localDatabaseService;
  }
  static LocalDatabaseService get localDatabaseServices =>
      _localDatabaseService;

  Database? _database;

  Future openDb() async {
    _database ??= await openDatabase(
        join(await getDatabasesPath(), "movies.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE favourites(id INTEGER PRIMARY KEY autoincrement, name TEXT , movieId TEXT , date TEXT, rating TEXT,language TEXT,description TEXT )",
      );
    });
  }

  Future<int> insertMovie(FavouriteModel results) async {
    await openDb();

    return await _database!.insert('favourites', results.toMap());
  }

  Future<void> deleteMovie(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!
        .query('favourites', where: "name = ?", whereArgs: [name]);
    for (var temp in maps) {
      await _database!
          .delete('favourites', where: "id = ?", whereArgs: [temp['id']]);
    }
  }

  Future<List<FavouriteModel>> getMovies() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database!.rawQuery('SELECT * from favourites');
    return List.generate(maps.length, (i) {
      return FavouriteModel(
          name: maps[i]['name'],
          date: maps[i]['date'],
          description: maps[i]['description'],
          movieId: maps[i]['movieId'],
          language: maps[i]["language"],
          rating: maps[i]["rating"]);
    });
  }

  Future<bool> checkMovie(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!
        .query('favourites', where: "name = ?", whereArgs: [name]);
    if (maps.isNotEmpty) {
      print(maps);
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }
}
