import 'package:flutter/material.dart';
import '../../shared/models/news_model.dart';
import '../../shared/services/news_service.dart';

class HomeProvider extends ChangeNotifier {
  List<NewsModel> _allNews = [];
  String _selectedCategory = 'TODAS';
  bool _isLoading = false;

  List<NewsModel> get allNews => _allNews;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  List<NewsModel> get filteredNews {
    if (_selectedCategory == 'TODAS') {
      return _allNews.where((n) => !n.destaque).toList();
    }
    return _allNews.where((n) => n.categoria == _selectedCategory && !n.destaque).toList();
  }

  NewsModel? get highlightNews {
    try {
      return _allNews.firstWhere((n) => n.destaque);
    } catch (e) {
      return _allNews.isNotEmpty ? _allNews.first : null;
    }
  }

  void loadNews() async {
    _isLoading = true;
    notifyListeners();
    _allNews = await NewsService.fetchAgroNews();
    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1500));
    loadNews();
    _isLoading = false;
    notifyListeners();
  }
}
