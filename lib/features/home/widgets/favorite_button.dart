import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/models/news_model.dart';
import '../../../shared/services/favorites_service.dart';
import '../../../core/constants/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  final NewsModel news;

  const FavoriteButton({super.key, required this.news});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> with SingleTickerProviderStateMixin {
  final _service = FavoritesService();
  bool _isFavorite = false;
  bool _isLoading = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _checkFavorite();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _checkFavorite() async {
    final isFav = await _service.isFavorite(widget.news.id);
    if (mounted) {
      setState(() => _isFavorite = isFav);
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    HapticFeedback.lightImpact();

    try {
      await _service.toggleFavorite(widget.news);
      setState(() => _isFavorite = !_isFavorite);

      _animController.forward().then((_) => _animController.reverse());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isFavorite ? 'adicionado aos favoritos' : 'removido dos favoritos',
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('erro ao atualizar favoritos'),
            backgroundColor: AppColors.alertaMarrom,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        onPressed: _isLoading ? null : _toggleFavorite,
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                _isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: _isFavorite ? AppColors.douradoTrigo : null,
              ),
      ),
    );
  }
}
