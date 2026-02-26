import '../models/news_model.dart';
import '../data/mock_news.dart';

class NewsService {
  static Future<List<NewsModel>> fetchAgroNews() async {
    // Por enquanto retorna mock
    // TODO: Implementar integração com RSS quando dependências estiverem instaladas
    await Future.delayed(const Duration(milliseconds: 500));
    return MockNews.getNews();
  }
}
