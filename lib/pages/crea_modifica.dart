import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lista_spesa/dati/articolo.dart';
import 'package:lista_spesa/dati/articolo_db.dart';
import 'package:lista_spesa/pages/list_articoli.dart';

class CreaModifica extends StatefulWidget {
  final Articolo articolo;
  final bool nuovo;

  const CreaModifica(this.articolo, this.nuovo);

  @override
  State<CreaModifica> createState() => _CreaModificaState();
}

class _CreaModificaState extends State<CreaModifica> {
  final TextEditingController txtNome = TextEditingController();
  final TextEditingController txtNote = TextEditingController();
  final TextEditingController txtQuantita = TextEditingController();
  final TextEditingController unitaMisura = TextEditingController();

  @override
  void initState() {
    if (!widget.nuovo) {
      txtNome.text = widget.articolo.nome;
      txtQuantita.text = widget.articolo.quantita;
      unitaMisura.text = widget.articolo.unitaMisura;
      txtNote.text = widget.articolo.note ?? '';
    }
    print(txtNome.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.nuovo ? 'Aggiungi articolo' : 'Modifica articolo')),
      floatingActionButton: FloatingActionButton(
          child: Icon(widget.nuovo ? Icons.save : Icons.save_as),
          onPressed: () => salvaArticolo()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputText(txtNome, 'Nome'),
            InputText(txtQuantita, 'Quantità'),
            InputText(unitaMisura, 'Unità di misura es. gr'),
            InputText(txtNote, 'Note eventuali'),
          ],
        ),
      ),
    );
  }

  Future salvaArticolo() async {
    ArticoloDb db = ArticoloDb();
    widget.articolo.nome = txtNome.text;
    widget.articolo.quantita = txtQuantita.text;
    widget.articolo.unitaMisura = unitaMisura.text;
    widget.articolo.note = txtNote.text;

    if (widget.nuovo) {
      await db.iniserisciArticolo(widget.articolo);
    } else {
      await db.aggiornaArticoli(widget.articolo);
    }
    Navigator.push(context, MaterialPageRoute(builder: (c) => ListaArticoli()));
  }
}

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String titolo;

  InputText(this.controller, this.titolo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: titolo),
      ),
    );
  }
}
