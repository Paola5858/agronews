class CommentModel {
  final String id;
  final String autor;
  final String avatarUrl;
  final String conteudo;
  final DateTime data;
  final int likes;
  final List<CommentModel> respostas;

  CommentModel({
    required this.id,
    required this.autor,
    required this.avatarUrl,
    required this.conteudo,
    required this.data,
    this.likes = 0,
    this.respostas = const [],
  });
}
