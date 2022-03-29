class Articolo {
  int? id = 0;
  String nome = '';
  String? note = '';
  String unitaMisura = 'pz';
  String quantita = '';

  Articolo(this.id, this.nome, this.note, this.quantita, this.unitaMisura);

  Map<String, dynamic> transformaInMap() {
    return {
      'id': id,
      'nome': nome,
      'quantita': quantita,
      'note': note,
      'unitaMisura': unitaMisura
    };
  }

  Articolo.daMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    quantita = map['quantita'];
    note = map['note'];
    unitaMisura = map['unitaMisura'];
  }
}
