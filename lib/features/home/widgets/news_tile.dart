import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../shared/models/news_model.dart';
import '../../../core/constants/app_colors.dart';

class NewsTile extends StatefulWidget {
  final NewsModel news;
  final VoidCallback onTap;
  final int index;

  const NewsTile({
    super.key,
    required this.news,
    required this.onTap,
    required this.index,
  });

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool _isPressed = false;

  Color _getCategoryColor() {
    switch (widget.news.categoria) {
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (widget.index * 50)),
      curve: Curves.easeOutBack,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark 
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark 
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.transparent,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.douradoTrigo.withValues(alpha: isDark ? 0.0 : 0.08),
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getCategoryColor().withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.news.categoria,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _getCategoryColor(),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.news.titulo,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.news.tempo,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Hero(
                  tag: 'news_image_${widget.news.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: widget.news.imagem,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildShimmer(isDark),
                      errorWidget: (context, url, error) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error_outline),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(bool isDark) {
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBase,
      highlightColor: isDark ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlight,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.white,
      ),
    );
  }
}
