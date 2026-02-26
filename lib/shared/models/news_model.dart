import 'package:intl/intl.dart';

class NewsModel {
  final String titulo;
  final String resumo;
  final String categoria;
  final DateTime data;
  final String imagemUrl;
  final String conteudo;
  final String autor;
  final String fonte;
  bool destaque;

  NewsModel({
    required this.titulo,
    required this.resumo,
    required this.categoria,
    required this.data,
    required this.imagemUrl,
    required this.conteudo,
    required this.autor,
    required this.fonte,
    this.destaque = false,
  });

  String get id => titulo.hashCode.toString();

  String get tempo {
    final now = DateTime.now();
    final difference = now.difference(data);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}min atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h atrás';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d atrás';
    } else {
      return DateFormat('dd/MM/yyyy').format(data);
    }
  }

  String get imagem => imagemUrl;

  int get minutosLeitura {
    final palavras = conteudo.split(' ').length;
    return (palavras / 200).ceil().clamp(1, 30);
  }

  String get tempoLeitura => '$minutosLeitura min de leitura';
}
