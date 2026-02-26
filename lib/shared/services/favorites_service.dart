import 'dart:convert';
import '../../core/config/supabase_config.dart';
import '../models/news_model.dart';

class FavoritesService {
  final _client = SupabaseConfig.client;

  Future<List<NewsModel>> getFavorites() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _client
        .from('favorites')
        .select('news_data')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => NewsModel.fromJson(item['news_data'] as Map<String, dynamic>))
        .toList();
  }

  Future<bool> isFavorite(String newsId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return false;

    final response = await _client
        .from('favorites')
        .select('id')
        .eq('user_id', userId)
        .eq('news_id', newsId)
        .maybeSingle();

    return response != null;
  }

  Future<void> addFavorite(NewsModel news) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client.from('favorites').insert({
      'user_id': userId,
      'news_id': news.id,
      'news_data': jsonEncode(news.toJson()),
    });
  }

  Future<void> removeFavorite(String newsId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _client
        .from('favorites')
        .delete()
        .eq('user_id', userId)
        .eq('news_id', newsId);
  }

  Future<void> toggleFavorite(NewsModel news) async {
    if (await isFavorite(news.id)) {
      await removeFavorite(news.id);
    } else {
      await addFavorite(news);
    }
  }
}
