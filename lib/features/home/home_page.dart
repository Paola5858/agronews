import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/models/news_model.dart';
import '../../shared/data/mock_news.dart';
import '../../core/constants/app_colors.dart';
import 'widgets/weather_widget.dart';
import 'widgets/highlight_card.dart';
import 'widgets/news_tile.dart';

/// Provider para gerenciar estado da home
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
    return _allNews.firstWhere((n) => n.destaque, orElse: () => _allNews.first);
  }

  void loadNews() {
    _allNews = MockNews.getNews();
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

/// Página principal com SliverAppBar colapsável
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final categories = MockNews.getCategories();

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.verdeProfundo,
        onRefresh: provider.refresh,
        child: CustomScrollView(
          slivers: [
            // SliverAppBar colapsável
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Raiz',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.laranjaAmbar,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),

            // Conteúdo
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  // Widget de clima
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: WeatherWidget(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Card de destaque
                  if (provider.highlightNews != null)
                    HighlightCard(
                      news: provider.highlightNews!,
                      onTap: () => _navigateToDetail(context, provider.highlightNews!),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Filtro de categorias
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = provider.selectedCategory == category;
                        
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (_) => provider.selectCategory(category),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : null,
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                            selectedColor: AppColors.verdeProfundo,
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Lista de notícias
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final news = provider.filteredNews[index];
                  return NewsTile(
                    news: news,
                    index: index,
                    onTap: () => _navigateToDetail(context, news),
                  );
                },
                childCount: provider.filteredNews.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, NewsModel news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(news: news),
      ),
    );
  }
}

/// Tela de detalhe da notícia com Hero animation
class NewsDetailPage extends StatelessWidget {
  final NewsModel news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'news_image_${news.id}',
                child: Image.network(
                  news.imagem,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.laranjaAmbar,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      news.categoria,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    news.titulo,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        news.tempo,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    news.resumo,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
