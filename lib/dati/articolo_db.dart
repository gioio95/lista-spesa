import 'articolo.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ArticoloDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database _db;

  final store = intMapStoreFactory.store('STORE_ARTICOLI');

  Future _openDb() async {
    final percorsoDocumenti = await getApplicationDocumentsDirectory();
    final percorsoDb = join(percorsoDocumenti.path, 'articoli.db');
    final db = await dbFactory.openDatabase(percorsoDb);
    return db;
  }

  Future iniserisciArticolo(Articolo articolo) async {
    Database db = await _openDb();
    int id = await store.add(db, articolo.transformaInMap());
    return id;
  }

  Future<List<Articolo>> leggiArticoli() async {
    Database db = await _openDb();
    final finder = Finder(sortOrders: [
      SortOrder('id'),
    ]);
    final articoliSnapshot = await store.find(db, finder: finder);
    return articoliSnapshot.map((e) {
      final articolo = Articolo.daMap(e.value);
      articolo.id = e.key;
      return articolo;
    }).toList();
  }

  Future aggiornaArticoli(Articolo articolo) async {
    Database db = await _openDb();
    final finder = Finder(filter: Filter.byKey(articolo.id));
    await store.update(db, articolo.transformaInMap(), finder: finder);
  }

  Future eliminaArticolo(Articolo articolo) async {
    Database db = await _openDb();
    final finder = Finder(filter: Filter.byKey(articolo.id));
    await store.delete(db, finder: finder);
  }

  Future eliminaTuttiGliArticolo() async {
    Database db = await _openDb();
    await store.delete(db);
  }
}
