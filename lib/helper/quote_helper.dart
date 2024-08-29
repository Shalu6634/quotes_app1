import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuotesHelper {
  Future<Map<String, dynamic>?> fetchData() async {
    Uri url = Uri.parse('https://api-get-quotes.vercel.app/api/v1/quotes');
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      return data;
    } else {
      return {};
    }
  }

  static QuotesHelper quotesHelper = QuotesHelper._();
  QuotesHelper._();

  Database? _db;

  Future<Database?> get database async => _db ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'quoteData.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE quoteData(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category TEXT,
          quote TEXT,
          author TEXT,
          description TEXT
        );''';
        await db.execute(sql);
      },
    );
    return _db!;
  }

  Future<void> insertData(String category,String quote,String author,String description)
  async {
    Database? db = await database;
    String sql='''
    INSERT INTO quoteData(category,quote,author,description) VALUES(?,?,?,?);
    ''';
    List args=[category,quote,author,description];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map<String, Object?>>> readData() async {
    Database? db = await database;
    String sql = '''
    SELECT * FROM quoteData;
    ''';
    return await db!.rawQuery(sql);
  }
}