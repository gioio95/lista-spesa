import 'package:flutter/material.dart';
import 'package:lista_spesa/dati/articolo.dart';
import 'package:lista_spesa/dati/articolo_db.dart';
import 'package:lista_spesa/pages/crea_modifica.dart';

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
      appBar: AppBar(title: const Text('Lista della spesa'), actions: [
        IconButton(
            onPressed: () => cancellaTutto(),
            icon: const Icon(Icons.delete_sweep))
      ]),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
          List<Articolo> lista = snapShot.data ?? [];
          return ListView.builder(
            itemBuilder: ((context, index) => Dismissible(
                  key: Key(lista[index].id.toString()),
                  onDismissed: (_) {
                    if (lista[index] != null) db.eliminaArticolo(lista[index]);
                  },
                  child: ListTile(
                    title: Text(lista[index].nome),
                    subtitle: Text('Quantità: ' +
                        (lista[index].quantita) +
                        (lista[index].unitaMisura) +
                        (lista[index].note != null
                            ? ' - Note: ' + (lista[index].note ?? '')
                            : '')),
                    onTap: () => _navigaVersoCreaModifica(lista[index], false),
                  ),
                )),
            itemCount: (lista == null) ? 0 : lista.length,
          );
        },
        future: leggiArticoli(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            _navigaVersoCreaModifica(Articolo(0, '', '', '', ''), true),
      ),
    );
  }

  _navigaVersoCreaModifica(Articolo articolo, bool crea) {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (c) => CreaModifica(articolo, crea));
    Navigator.push(context, route);
  }

  Future leggiArticoli() async {
    List<Articolo> articoli = await db.leggiArticoli();
    return articoli;
  }

  void cancellaTutto() {
    AlertDialog alert = AlertDialog(
      title: Text('Sei sicuro di voler svuotare la lista?'),
      content: Text('Non sarà possibile recuperare la lita'),
      actions: [
        TextButton(
            onPressed: () {
              db.eliminaTuttiGliArticolo().then((value) {
                setState(() {
                  db = ArticoloDb();
                });
                Navigator.pop(context);
              });
            },
            child: Text('Si')),
        TextButton(onPressed: () => Navigator.pop(context), child: Text('No'))
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
