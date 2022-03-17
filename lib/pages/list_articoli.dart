import 'package:flutter/material.dart';
import 'package:lista_spesa/dati/articolo.dart';
import 'package:lista_spesa/dati/articolo_db.dart';

class ListaArticoli extends StatefulWidget {
  const ListaArticoli({Key? key}) : super(key: key);

  @override
  State<ListaArticoli> createState() => _ListaArticoliState();
}

class _ListaArticoliState extends State<ListaArticoli> {
  late ArticoloDb db;

  @override
  void initState() {
    db = ArticoloDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lista della spesa')),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
            List<Articolo> lista = snapShot.data ?? [];
            return ListView.builder(
              itemBuilder: ((context, index) => ListTile(
                    title: Text(lista[index].nome ?? ''),
                    subtitle: Text('Quantità: ' +
                        (lista[index].quantita ?? '') +
                        (lista[index].unitaMisura ?? '') +
                        (lista[index].note != ''
                            ? ' - Note: ' + lista[index].note
                            : '')),
                  )),
              itemCount: (lista == null) ? 0 : lista.length,
            );
          },
          future: leggiArticoli(),
        ));
  }

  Future leggiArticoli() async {
    List<Articolo> articoli = await db.leggiArticoli();
    return articoli;
  }
}
