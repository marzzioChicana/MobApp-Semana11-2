import 'package:semana12_1/models/list_items.dart';
import 'package:semana12_1/models/shopping_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Creo la clas DBHelper
class DBHelper {
  // Creo una constante para la versión de la BD
  final int version = 1;

  // Creo un objeto de la clase Database
  // Esta clase es de sqflite
  Database? db;

  // Ahora creo la clase "openDB"
  Future<Database> openDb() async {
    // Y aca hacemos una pregunta fundamental
    // No existe la BD?
    db ??= await openDatabase(join(await getDatabasesPath(),
      'shopping.db'),
      onCreate: (database, version) {
        database.execute('CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');

        // Creo la segunda tabla
        database.execute('CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity INTEGER, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id))');
      }, version: version);

    // No tiene else
    return db!; // Siempre devuelve la BD
  }

  Future testDB() async {
    // Llama al openDB
    db = await openDb();

    // Inserto valores en las tablas
    //await db!.execute('INSERT INTO lists VALUES(0, "Monitores", 1)');
    //await db!.execute('INSERT INTO lists VALUES(1, "Impresoras", 1)');
    //await db!.execute('INSERT INTO items VALUES(0, 0, "Apples", "5 Kgs", "Red apples")');

    // Mostramos los valores (usamos el método rawQuery)
    // Pasamos los valores de una lista
    List list = await db!.rawQuery('SELECT * FROM lists');
    List item = await db!.rawQuery('SELECT * FROM items');

    // Mostramos los valores en consola
    print(list);
    print(item);
  }

  // Metodo para hacer la insert en la tabla lists
  Future<int> insertList(ShoppingList list) async {
    int id = await this.db!.insert(
      'lists', list.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace); // Si hay un conflicto (si el registro existe), lo reemplaza

    return id;
  }

  // Metodo para hacer la insert en la tabla items
  Future<int> insertItem(ListItems item) async {
    int id = await this.db!.insert(
      'items', item.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace); // Si hay un conflicto (si el registro existe), lo reemplaza

    return id;
  }

  // Metodo para hacer listar los registros de la tabla lists
  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('lists');

    return List.generate(maps.length, (i){
      return ShoppingList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority']
      );
    });
  }
}