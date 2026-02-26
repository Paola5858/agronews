import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cotacoes = [
      {'nome': 'Soja', 'valor': 'R\$ 148,50', 'variacao': '+2.3%', 'positivo': true},
      {'nome': 'Milho', 'valor': 'R\$ 67,80', 'variacao': '-0.8%', 'positivo': false},
      {'nome': 'Café', 'valor': 'R\$ 1.240,00', 'variacao': '+1.1%', 'positivo': true},
      {'nome': 'Boi Gordo', 'valor': 'R\$ 312,00', 'variacao': '+0.5%', 'positivo': true},
      {'nome': 'Algodão', 'valor': 'R\$ 98,40', 'variacao': '-1.4%', 'positivo': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'o que o mercado tá fazendo agora',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              'cotações de hoje',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppColors.douradoTrigo,
              ),
            ),
            const SizedBox(height: 16),
            
            ...cotacoes.map((cotacao) {
              final positivo = cotacao['positivo'] as bool;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark 
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    left: BorderSide(
                      color: positivo ? AppColors.mercado : AppColors.alertaMarrom,
                      width: 4,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.douradoTrigo.withValues(alpha: isDark ? 0.0 : 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cotacao['nome'] as String,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cotacao['valor'] as String,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          positivo ? Icons.arrow_upward : Icons.arrow_downward,
                          color: positivo ? AppColors.mercado : AppColors.alertaMarrom,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          cotacao['variacao'] as String,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: positivo ? AppColors.mercado : AppColors.alertaMarrom,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            
            const SizedBox(height: 32),
            
            Text(
              'análise do dia',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppColors.douradoTrigo,
              ),
            ),
            const SizedBox(height: 16),
            
            Container(
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
              child: Text(
                'o milho perdeu força hoje, mas analistas apontam retomada até março. '
                'quem tem estoque, segura. quem não tem, observa o movimento antes de comprar.',
                style: GoogleFonts.lora(
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'histórico de cotações chegando na próxima versão.',
                        style: GoogleFonts.lora(),
                      ),
                      backgroundColor: AppColors.verdeOliva,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.verdeOliva, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'ver histórico',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: AppColors.verdeOliva,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
