import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsRepository {
  final _cache = <String, List<NewsModel>>{};
  DateTime? _lastFetch;
  static const _cacheTimeout = Duration(minutes: 5);

  Future<List<NewsModel>> getNews({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cache.isNotEmpty &&
        _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < _cacheTimeout) {
      return _cache['all']!;
    }

    final news = await NewsService.fetchAgroNews();
    _cache['all'] = news;
    _lastFetch = DateTime.now();
    return news;
  }

  Future<List<NewsModel>> getNewsByCategory(String category) async {
    final allNews = await getNews();
    if (category == 'TODAS') {
      return allNews.where((n) => !n.destaque).toList();
    }
    return allNews.where((n) => n.categoria == category && !n.destaque).toList();
  }

  NewsModel? getHighlight(List<NewsModel> news) {
    try {
      return news.firstWhere((n) => n.destaque);
    } catch (e) {
      return news.isNotEmpty ? news.first : null;
    }
  }

  void clearCache() {
    _cache.clear();
    _lastFetch = null;
  }
}
