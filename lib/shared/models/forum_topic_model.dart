import 'comment_model.dart';

class ForumTopicModel {
  final String id;
  final String titulo;
  final String descricao;
  final String categoria;
  final String autor;
  final String avatarUrl;
  final DateTime data;
  final int visualizacoes;
  final int comentarios;
  final List<CommentModel> discussao;
  final String icone;

  ForumTopicModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria,
    required this.autor,
    required this.avatarUrl,
    required this.data,
    this.visualizacoes = 0,
    this.comentarios = 0,
    this.discussao = const [],
    required this.icone,
  });
}
