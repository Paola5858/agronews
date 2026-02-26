import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/news_model.dart';
import '../../shared/data/mock_news.dart';
import '../../core/constants/app_colors.dart';
import 'widgets/weather_widget.dart';
import 'widgets/highlight_card.dart';
import 'widgets/news_tile.dart';
import 'widgets/category_pill.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasSeenNotifications = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadNews();
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'MERCADO':
        return AppColors.mercado;
      case 'TECH':
        return AppColors.tech;
      case 'PECUÁRIA':
        return AppColors.pecuaria;
      case 'ESTRATÉGIA':
        return AppColors.estrategia;
      case 'XADREZ DO AGRO':
        return AppColors.xadrezAgro;
      default:
        return AppColors.verdeOliva;
    }
  }

  void _showNotifications() {
    setState(() => _hasSeenNotifications = true);
    
    final alertas = [
      {'titulo': 'soja em alta', 'corpo': 'Chicago subiu 2.3% ontem. pode ser hora de revisar estoque.', 'tempo': 'há 15min', 'icone': Icons.trending_up},
      {'titulo': 'janela de plantio', 'corpo': 'milho safrinha: 12 dias pra fechar a janela ideal no MT.', 'tempo': 'há 1h', 'icone': Icons.warning_amber_outlined},
      {'titulo': 'nova linha de crédito', 'corpo': 'Pronaf lançou linha de irrigação a 5.5% ao ano. vale ler.', 'tempo': 'há 3h', 'icone': Icons.attach_money},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        'alertas',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: alertas.length,
                    itemBuilder: (context, index) {
                      final alerta = alertas[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark 
                            ? Colors.white.withValues(alpha: 0.05)
                            : AppColors.fundoClaro,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.douradoTrigo.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                alerta['icone'] as IconData,
                                color: AppColors.douradoTrigo,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        alerta['titulo'] as String,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        alerta['tempo'] as String,
                                        style: GoogleFonts.lora(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    alerta['corpo'] as String,
                                    style: GoogleFonts.lora(
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final categories = MockNews.getCategories();

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.verdeOliva,
        onRefresh: provider.refresh,
        child: CustomScrollView(
          slivers: [
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
                      onPressed: _showNotifications,
                    ),
                    if (!_hasSeenNotifications)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.douradoTrigo,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: WeatherWidget(),
                  ),
                  const SizedBox(height: 24),
                  if (provider.highlightNews != null)
                    HighlightCard(
                      news: provider.highlightNews!,
                      onTap: () => _navigateToDetail(context, provider.highlightNews!),
                    ),
                  const SizedBox(height: 24),
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
                          child: CategoryPill(
                            label: category,
                            isSelected: isSelected,
                            onTap: () => provider.selectCategory(category),
                            accentColor: _getCategoryColor(category),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            provider.filteredNews.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_alt_off,
                            size: 48,
                            color: AppColors.douradoTrigo.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'sem notícias nessa jogada',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'mude a categoria ou volte mais tarde.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.fundoEscuro.withValues(alpha: 0.45),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
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

class NewsDetailPage extends StatefulWidget {
  final NewsModel news;

  const NewsDetailPage({super.key, required this.news});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _readProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      setState(() {
        _readProgress = maxScroll > 0 ? (current / maxScroll).clamp(0.0, 1.0) : 0.0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'news_image_${widget.news.id}',
                    child: Image.network(
                      widget.news.imagem,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.douradoTrigo,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.news.categoria,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.news.titulo,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: isDark 
                              ? Colors.grey[400]
                              : AppColors.fundoEscuro.withValues(alpha: 0.45),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.news.tempo,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDark 
                                ? Colors.grey[400]
                                : AppColors.fundoEscuro.withValues(alpha: 0.45),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.menu_book_outlined,
                            size: 14,
                            color: isDark 
                              ? Colors.grey[400]
                              : AppColors.fundoEscuro.withValues(alpha: 0.45),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.news.tempoLeitura,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDark 
                                ? Colors.grey[400]
                                : AppColors.fundoEscuro.withValues(alpha: 0.45),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        widget.news.resumo,
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
          
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: _readProgress,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.douradoTrigo),
              minHeight: 3,
            ),
          ),
        ],
      ),
    );
  }
}
