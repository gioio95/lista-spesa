import 'package:lista_spesa/dati/articolo.dart';
import 'package:lista_spesa/pages/list_articoli.dart';

import './dati/articolo_db.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaArticoli(),
    );
  }
}

class ProvaDb extends StatefulWidget {
  ProvaDb({Key? key}) : super(key: key);

  @override
  State<ProvaDb> createState() => _ProvaDbState();
}

class _ProvaDbState extends State<ProvaDb> {
  int id = 0;

  @override
  void initState() {
    super.initState();
    provaDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spesa libri')),
      body: Center(child: Text(id.toString())),
    );
  }

  Future provaDb() async {
    ArticoloDb articoloDb = ArticoloDb();
    Articolo articolo = Articolo(0, 'arancia', '', '3', 'kg');
    id = await articoloDb.iniserisciArticolo(articolo);
    setState(() {
      print(id);
      id = id;
    });
  }
}
