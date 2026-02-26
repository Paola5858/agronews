import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../core/constants/app_colors.dart';
import '../../shared/data/mock_forum.dart';
import 'forum_detail_page.dart';

class StrategyPage extends StatefulWidget {
  const StrategyPage({super.key});

  @override
  State<StrategyPage> createState() => _StrategyPageState();
}

class _StrategyPageState extends State<StrategyPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _filtroCategoria = 'Todos';

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topics = _filtroCategoria == 'Todos'
        ? mockForumTopics
        : mockForumTopics.where((t) => t.categoria == _filtroCategoria).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: isDark ? AppColors.verdeOliva : AppColors.verdeOliva,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Fórum Estratégico',
                style: GoogleFonts.cormorantGaramond(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.verdeOliva,
                      AppColors.verdeOliva.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.forum_outlined,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xadrez do Agro',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.verdeOliva,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Discuta estratégias com quem pensa o campo como tabuleiro.',
                    style: GoogleFonts.lora(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Todos', isDark),
                        _buildFilterChip('Peão', isDark),
                        _buildFilterChip('Torre', isDark),
                        _buildFilterChip('Rainha', isDark),
                        _buildFilterChip('Bispo', isDark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final topic = topics[index];
                return FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        index * 0.1,
                        1.0,
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          index * 0.1,
                          1.0,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    ),
                    child: _buildTopicCard(topic, isDark),
                  ),
                );
              },
              childCount: topics.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Criar novo tópico (em breve)')),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Novo Tópico'),
        backgroundColor: AppColors.douradoTrigo,
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isDark) {
    final isSelected = _filtroCategoria == label;
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _filtroCategoria = label;
            _controller.reset();
            _controller.forward();
          });
        },
        backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
        selectedColor: AppColors.douradoTrigo,
        labelStyle: GoogleFonts.montserrat(
          color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTopicCard(topic, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850]?.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForumDetailPage(topic: topic),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(topic.avatarUrl),
                      radius: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic.autor,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            timeago.format(topic.data, locale: 'pt_BR'),
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.douradoTrigo.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            topic.icone,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 4),
                          Text(
                            topic.categoria,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.douradoTrigo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  topic.titulo,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.verdeOliva,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  topic.descricao,
                  style: GoogleFonts.lora(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.visibility_outlined, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      '${topic.visualizacoes}',
                      style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.comment_outlined, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      '${topic.comentarios}',
                      style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.douradoTrigo),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
