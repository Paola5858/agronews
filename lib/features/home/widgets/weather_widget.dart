import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

/// Widget de clima mockado — dados simulados para demonstração
/// Preparado para integração futura com API de clima
class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showForecast() {
    final previsao = [
      {'dia': 'hoje', 'max': '31°', 'min': '22°', 'icone': Icons.wb_sunny, 'condicao': 'sol forte — hidratação no campo'},
      {'dia': 'amanhã', 'max': '28°', 'min': '20°', 'icone': Icons.cloud, 'condicao': 'parcialmente nublado'},
      {'dia': 'quarta', 'max': '25°', 'min': '19°', 'icone': Icons.umbrella, 'condicao': 'chuva leve — evite pulverização'},
      {'dia': 'quinta', 'max': '29°', 'min': '21°', 'icone': Icons.wb_cloudy, 'condicao': 'nublado com aberturas'},
      {'dia': 'sexta', 'max': '33°', 'min': '23°', 'icone': Icons.wb_sunny, 'condicao': 'calor forte — alerta de estresse hídrico'},
    ];

    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Dialog(
          backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'previsão — Campo Grande',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...previsao.map((dia) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark 
                      ? Colors.white.withValues(alpha: 0.05)
                      : AppColors.fundoClaro,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        dia['icone'] as IconData,
                        color: AppColors.douradoTrigo,
                        size: 28,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dia['dia'] as String,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  '${dia['max']} / ${dia['min']}',
                                  style: GoogleFonts.lora(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dia['condicao'] as String,
                              style: GoogleFonts.lora(
                                fontSize: 12,
                                color: isDark 
                                  ? Colors.grey[400]
                                  : AppColors.fundoEscuro.withValues(alpha: 0.45),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showForecast,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.verdeOliva.withValues(alpha: 0.12),
              AppColors.douradoTrigo.withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.douradoTrigo.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            RotationTransition(
              turns: _controller,
              child: const Icon(
                Icons.wb_sunny,
                color: AppColors.douradoTrigo,
                size: 36,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campo Grande, MS',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '28°C · céu limpo · ideal pra colheita',
                    style: GoogleFonts.lora(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
