/// Modelo de dados para notícias
class NewsModel {
  final String id;
  final String titulo;
  final String categoria;
  final String tempo;
  final String imagem;
  final String resumo;
  final bool destaque;

  NewsModel({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.tempo,
    required this.imagem,
    required this.resumo,
    this.destaque = false,
  });

  int get minutosLeitura {
    final palavras = resumo.split(' ').length;
    return (palavras / 200).ceil();
  }

  String get tempoLeitura => '$minutosLeitura min de leitura';

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      titulo: json['titulo'],
      categoria: json['categoria'],
      tempo: json['tempo'],
      imagem: json['imagem'],
      resumo: json['resumo'],
      destaque: json['destaque'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'categoria': categoria,
      'tempo': tempo,
      'imagem': imagem,
      'resumo': resumo,
      'destaque': destaque,
    };
  }
}
