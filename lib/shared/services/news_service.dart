import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../models/news_model.dart';

class NewsService {
  static final List<Map<String, String>> _rssSources = [
    {
      'url': 'https://www.canalrural.com.br/feed/',
      'categoria': 'Mercado',
    },
    {
      'url': 'https://www.agrolink.com.br/rss/noticias.xml',
      'categoria': 'Tecnologia',
    },
  ];

  Future<List<NewsModel>> fetchNews() async {
    List<NewsModel> allNews = [];

    for (var source in _rssSources) {
      try {
        final response = await http.get(Uri.parse(source['url']!));
        if (response.statusCode == 200) {
          final document = XmlDocument.parse(response.body);
          final items = document.findAllElements('item');

          for (var item in items.take(10)) {
            final title = item.findElements('title').first.innerText;
            final description = item.findElements('description').first.innerText
                .replaceAll(RegExp(r'<[^>]*>'), '')
                .replaceAll('&nbsp;', ' ')
                .trim();
            final link = item.findElements('link').first.innerText;
            final pubDate = item.findElements('pubDate').isNotEmpty
                ? item.findElements('pubDate').first.innerText
                : '';

            String? imageUrl;
            final mediaContent = item.findElements('media:content');
            if (mediaContent.isNotEmpty) {
              imageUrl = mediaContent.first.getAttribute('url');
            } else {
              final enclosure = item.findElements('enclosure');
              if (enclosure.isNotEmpty) {
                imageUrl = enclosure.first.getAttribute('url');
              }
            }

            allNews.add(NewsModel(
              titulo: title,
              resumo: description.length > 200
                  ? '${description.substring(0, 200)}...'
                  : description,
              categoria: source['categoria']!,
              data: _parseDate(pubDate),
              imagemUrl: imageUrl ?? 'https://via.placeholder.com/400x200',
              conteudo: description,
              autor: 'Redação',
              fonte: link,
            ));
          }
        }
      } catch (e) {
        print('Erro ao buscar RSS ${source['url']}: $e');
      }
    }

    allNews.sort((a, b) => b.data.compareTo(a.data));
    return allNews.take(20).toList();
  }

  DateTime _parseDate(String dateStr) {
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      try {
        final months = {
          'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
          'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
          'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
        };
        final parts = dateStr.split(' ');
        if (parts.length >= 4) {
          final day = parts[1].padLeft(2, '0');
          final month = months[parts[2]] ?? '01';
          final year = parts[3];
          return DateTime.parse('$year-$month-$day');
        }
      } catch (_) {}
      return DateTime.now();
    }
  }
}
