import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import 'strategy_detail_page.dart';

class StrategyPage extends StatelessWidget {
  const StrategyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jogadas = [
      {
        'icone': Icons.circle_outlined,
        'jogada': 'peão',
        'titulo': 'A decisão que parece pequena',
        'descricao': 'timing do plantio é o primeiro peão do tabuleiro. errar essa jogada contamina todas as outras.',
      },
      {
        'icone': Icons.castle_outlined,
        'jogada': 'torre',
        'titulo': 'Estoque como poder',
        'descricao': 'quem controla o armazenamento, controla o preço. a torre defende e avança ao mesmo tempo.',
      },
      {
        'icone': Icons.star_outline,
        'jogada': 'rainha',
        'titulo': 'Tecnologia multiplica tudo',
        'descricao': 'uma fazenda sem dado é como um xadrez sem rainha. você joga, mas com metade do poder.',
      },
      {
        'icone': Icons.trending_up,
        'jogada': 'bispo',
        'titulo': 'Visão diagonal',
        'descricao': 'mercado não é linha reta. quem enxerga só o óbvio, perde a jogada antes de começar.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Xadrez do Agro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'quem planta sem visão, colhe sorte',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'o campo também tem eras. quem não percebe, vira figurante.',
              style: GoogleFonts.lora(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: jogadas.length,
              itemBuilder: (context, index) {
                final jogada = jogadas[index];
                return _buildJogadaCard(context, jogada);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJogadaCard(BuildContext context, Map<String, dynamic> jogada) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StrategyDetailPage(jogada: jogada),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppColors.xadrezAgro.withValues(alpha: 0.3),
                    AppColors.verdeOliva.withValues(alpha: 0.1),
                  ]
                : [
                    AppColors.verdeOliva.withValues(alpha: 0.08),
                    AppColors.douradoTrigo.withValues(alpha: 0.05),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.douradoTrigo.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              jogada['icone'] as IconData,
              size: 36,
              color: AppColors.douradoTrigo,
            ),
            const SizedBox(height: 12),
            Text(
              jogada['jogada'] as String,
              style: GoogleFonts.montserrat(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: AppColors.douradoTrigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              jogada['titulo'] as String,
              style: GoogleFonts.lora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                jogada['descricao'] as String,
                style: GoogleFonts.lora(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
