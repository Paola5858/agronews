import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import '../data/mock_news.dart';
import '../../core/errors/app_error.dart';

class NewsService {
  static const _apiKey = 'SUA_API_KEY_AQUI';
  static const _baseUrl = 'https://newsapi.org/v2/everything';
  static const _timeout = Duration(seconds: 10);

  static Future<List<NewsModel>> fetchAgroNews() async {
    final uri = Uri.parse(
      '$_baseUrl?q=agronegocio+soja+milho+pecuaria&language=pt&sortBy=publishedAt&apiKey=$_apiKey'
    );

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final articles = data['articles'] as List;

        return articles.map((article) => NewsModel(
          id: article['url'] ?? '',
          titulo: article['title'] ?? 'sem título',
          categoria: _inferirCategoria(article['title'] ?? ''),
          tempo: _formatarTempo(article['publishedAt']),
          imagem: article['urlToImage'] ?? 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=800',
          resumo: article['description'] ?? article['content'] ?? '',
          destaque: false,
        )).toList();
      } else if (response.statusCode >= 500) {
        throw ServerError(details: 'Status: ${response.statusCode}');
      } else {
        throw UnknownError(details: 'Status: ${response.statusCode}');
      }
    } on SocketException {
      throw NetworkError();
    } on FormatException {
      throw DataParsingError();
    } catch (e) {
      if (e is AppError) rethrow;
      return MockNews.getNews();
    }
  }

  static String _inferirCategoria(String titulo) {
    final t = titulo.toLowerCase();
    if (t.contains('soja') || t.contains('milho') || t.contains('preço') || t.contains('cotação')) return 'MERCADO';
    if (t.contains('drone') || t.contains('tecnologia') || t.contains('ia') || t.contains('digital')) return 'TECH';
    if (t.contains('boi') || t.contains('pecuária') || t.contains('gado')) return 'PECUÁRIA';
    if (t.contains('estratégia') || t.contains('gestão') || t.contains('produtividade')) return 'ESTRATÉGIA';
    return 'MERCADO';
  }

  static String _formatarTempo(String? isoDate) {
    if (isoDate == null) return 'recente';
    try {
      final dt = DateTime.parse(isoDate);
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 60) return 'há ${diff.inMinutes}min';
      if (diff.inHours < 24) return 'há ${diff.inHours}h';
      return 'há ${diff.inDays} dia${diff.inDays > 1 ? 's' : ''}';
    } catch (e) {
      return 'recente';
    }
  }
}
