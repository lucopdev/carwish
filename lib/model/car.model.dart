class Car {
  final int id;
  final int timestampCadastro;
  final int modeloId;
  final int ano;
  final String combustivel;
  final int numPortas;
  final String cor;
  final String nomeModelo;
  final double valor;

  Car({
    required this.id,
    required this.timestampCadastro,
    required this.modeloId,
    required this.ano,
    required this.combustivel,
    required this.numPortas,
    required this.cor,
    required this.nomeModelo,
    required this.valor,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int,
      timestampCadastro: json['timestamp_cadastro'] as int,
      modeloId: json['modelo_id'] as int,
      ano: json['ano'] as int,
      combustivel: json['combustivel'] as String,
      numPortas: json['num_portas'] as int,
      cor: json['cor'] as String,
      nomeModelo: json['nome_modelo'] as String,
      valor: json['valor'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp_cadastro': timestampCadastro,
      'modelo_id': modeloId,
      'ano': ano,
      'combustivel': combustivel,
      'num_portas': numPortas,
      'cor': cor,
      'nome_modelo': nomeModelo,
      'valor': valor,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] as int,
      timestampCadastro: map['timestamp_cadastro'] as int,
      modeloId: map['modelo_id'] as int,
      ano: map['ano'] as int,
      combustivel: map['combustivel'] as String,
      numPortas: map['num_portas'] as int,
      cor: map['cor'] as String,
      nomeModelo: map['nome_modelo'] as String,
      valor: map['valor'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp_cadastro': timestampCadastro,
      'modelo_id': modeloId,
      'ano': ano,
      'combustivel': combustivel,
      'num_portas': numPortas,
      'cor': cor,
      'nome_modelo': nomeModelo,
      'valor': valor,
    };
  }
}
