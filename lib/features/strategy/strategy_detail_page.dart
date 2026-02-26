import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class StrategyDetailPage extends StatelessWidget {
  final Map<String, dynamic> jogada;

  const StrategyDetailPage({super.key, required this.jogada});

  String _getConteudoExpandido() {
    switch (jogada['jogada']) {
      case 'peão':
        return 'o peão parece fraco. mas é ele que decide o jogo antes de começar. '
            'na prática agrícola, o timing do plantio é essa peça. uma semana de '
            'atraso pode representar 15% a menos de produtividade. não por falta '
            'de técnica, mas por descuido com o calendário.\n\n'
            'os produtores que mais lucram não são necessariamente os que têm mais '
            'terra. são os que plantam na janela certa, com o dado certo na mão.\n\n'
            'monitorar janela climática, cruzar com preço de mercado projetado e '
            'decidir com antecedência. isso é xadrez. não instinto.';
      case 'torre':
        return 'a torre é a peça mais subestimada do tabuleiro. ela não tem movimento '
            'elegante, mas protege e avança ao mesmo tempo.\n\n'
            'no agro, isso é o armazenamento. quem tem silo, tem tempo. tempo de '
            'esperar o mercado subir, tempo de negociar melhor, tempo de não vender '
            'no pior momento por pressão de caixa.\n\n'
            'a maioria dos produtores vende na colheita porque não tem onde guardar. '
            'esse é o custo invisível de não investir em estrutura. quem investe em '
            'armazenagem não está gastando, está comprando tempo de decisão.';
      case 'rainha':
        return 'a rainha move em todas as direções. é a peça com mais liberdade no '
            'tabuleiro. e ela representa exatamente o que a tecnologia faz no agro.\n\n'
            'sensores de solo, drones de mapeamento, plataformas de gestão, IA '
            'preditiva. cada uma dessas ferramentas multiplica a capacidade de '
            'decisão. não substituem o produtor, amplificam.\n\n'
            'uma fazenda sem dado é uma fazenda jogando com metade das peças. '
            'você até consegue jogar. mas o adversário que tem os dados, vence mais.';
      case 'bispo':
        return 'o bispo não vai em linha reta. ele cruza o tabuleiro em diagonal, vendo '
            'conexões que as outras peças não enxergam.\n\n'
            'no mercado do agro, isso é a leitura indireta. não é só acompanhar o '
            'preço da soja. é entender o que o dólar tá fazendo, o que a China '
            'importou no trimestre, o que o clima da Argentina significa pra sua '
            'safra.\n\n'
            'quem lê só o óbvio, reage. quem lê o diagonal, antecipa.';
      default:
        return '';
    }
  }

  String _getFraseImpacto() {
    switch (jogada['jogada']) {
      case 'peão':
        return 'um peão bem posicionado vence a partida antes do final.';
      case 'torre':
        return 'controle o armazenamento. controle o preço.';
      case 'rainha':
        return 'tecnologia não é custo. é margem que você ainda não capturou.';
      case 'bispo':
        return 'o mercado não é linha reta. quem enxerga só o óbvio, perde a jogada antes de começar.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            AppColors.xadrezAgro.withValues(alpha: 0.5),
                            AppColors.verdeOliva.withValues(alpha: 0.3),
                          ]
                        : [
                            AppColors.verdeOliva.withValues(alpha: 0.15),
                            AppColors.douradoTrigo.withValues(alpha: 0.1),
                          ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    jogada['icone'] as IconData,
                    size: 80,
                    color: AppColors.douradoTrigo,
                  ),
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
                  Text(
                    jogada['jogada'] as String,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: AppColors.douradoTrigo,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    jogada['titulo'] as String,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _getConteudoExpandido(),
                    style: GoogleFonts.lora(
                      fontSize: 16,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: isDark 
                          ? Colors.white.withValues(alpha: 0.05)
                          : AppColors.fundoClaro,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _getFraseImpacto(),
                        style: GoogleFonts.lora(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
