import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../models/news_model.dart';
import '../data/mock_news.dart';

class NewsService {
  // RSS feeds de portais do agronegócio
  static const _rssFeeds = [
    'https://www.canalrural.com.br/feed/',
    'https://www.agrolink.com.br/rss/noticias.xml',
  ];

  static Future<List<NewsModel>> fetchAgroNews() async {
    try {
      final allNews = <NewsModel>[];
      
      for (final feedUrl in _rssFeeds) {
        try {
          final response = await http.get(
            Uri.parse(feedUrl),
            headers: {'User-Agent': 'Mozilla/5.0'},
          ).timeout(const Duration(seconds: 10));
          
          if (response.statusCode == 200) {
            final document = XmlDocument.parse(utf8.decode(response.bodyBytes));
            final items = document.findAllElements('item');
            
            for (var item in items.take(10)) {
              final titulo = item.findElements('title').first.innerText;
              final link = item.findElements('link').first.innerText;
              final descricao = item.findElements('description').firstOrNull?.innerText ?? '';
              final pubDate = item.findElements('pubDate').firstOrNull?.innerText;
              
              // Tenta extrair imagem
              String? imagem;
              final mediaContent = item.findElements('media:content').firstOrNull;
              if (mediaContent != null) {
                imagem = mediaContent.getAttribute('url');
              }
              
              allNews.add(NewsModel(
                id: link,
                titulo: _cleanHtml(titulo),
                categoria: _inferirCategoria(titulo),
                tempo: _formatarTempo(pubDate),
                imagem: imagem ?? 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=800',
                resumo: _cleanHtml(descricao),
                destaque: allNews.isEmpty,
              ));
            }
          }
        } catch (e) {
          continue;
        }
      }
      
      if (allNews.isNotEmpty) {
        return allNews;
      }
    } catch (e) {
      // Fallback para mock
    }

    return MockNews.getNews();
  }

  static String _cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&#8211;', '-')
        .trim();
  }

  static String _inferirCategoria(String titulo) {
    final t = titulo.toLowerCase();
    if (t.contains('soja') || t.contains('milho') || t.contains('preço') || t.contains('cotação') || t.contains('mercado')) return 'MERCADO';
    if (t.contains('drone') || t.contains('tecnologia') || t.contains('digital') || t.contains('app')) return 'TECH';
    if (t.contains('boi') || t.contains('pecuária') || t.contains('gado') || t.contains('leite')) return 'PECUÁRIA';
    if (t.contains('estratégia') || t.contains('gestão') || t.contains('produtividade')) return 'ESTRATÉGIA';
    return 'MERCADO';
  }

  static String _formatarTempo(String? pubDate) {
    if (pubDate == null) return 'recente';
    try {
      final date = DateTime.parse(pubDate);
      final diff = DateTime.now().difference(date);
      if (diff.inMinutes < 60) return 'há ${diff.inMinutes}min';
      if (diff.inHours < 24) return 'há ${diff.inHours}h';
      if (diff.inDays == 1) return 'ontem';
      return 'há ${diff.inDays} dias';
    } catch (e) {
      return 'recente';
    }
  }
}
