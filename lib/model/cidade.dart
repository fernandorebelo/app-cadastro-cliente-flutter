class Cidade {
  int id;
  String nome;
  String uf;

  Cidade(
    this.id,
    this.nome,
    this.uf,
  );

  //Receber JSON
  factory Cidade.fromJson(dynamic json) {
    return Cidade(
      json['id'] as int,
      json['nome'] as String,
      json['uf'] as String,
    );
  }

  //Enviar método JSON
  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': nome,
        'uf': uf,
      };
}
