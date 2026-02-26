import '../models/news_model.dart';

/// Dados mockados — conteúdo temático real do agronegócio
/// Preparado para substituição por API
class MockNews {
  static List<NewsModel> getNews() {
    return [
      NewsModel(
        id: '1',
        titulo: 'Soja atinge R\$ 150 por saca em Chicago com tensão geopolítica',
        categoria: 'MERCADO',
        tempo: 'há 2h',
        imagem: 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=800',
        resumo: 'Cotação da soja dispara em Chicago após anúncio de restrições comerciais. Analistas projetam impacto direto no mercado brasileiro nas próximas semanas.',
        destaque: true,
      ),
      NewsModel(
        id: '2',
        titulo: 'Drones autônomos reduzem custo de pulverização em 40%',
        categoria: 'TECH',
        tempo: 'há 4h',
        imagem: 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=800',
        resumo: 'Startup brasileira desenvolve sistema de drones com IA que mapeia lavouras e aplica defensivos com precisão milimétrica, reduzindo desperdício.',
      ),
      NewsModel(
        id: '3',
        titulo: 'Pecuária de precisão: chips em bovinos aumentam produtividade',
        categoria: 'PECUÁRIA',
        tempo: 'há 6h',
        imagem: 'https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800',
        resumo: 'Tecnologia de monitoramento individual permite rastreamento de saúde, nutrição e comportamento do rebanho em tempo real.',
      ),
      NewsModel(
        id: '4',
        titulo: 'Xadrez do Agro: quando vender estoque é melhor que plantar',
        categoria: 'XADREZ DO AGRO',
        tempo: 'ontem às 18h',
        imagem: 'https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800',
        resumo: 'Análise estratégica mostra que produtores que seguraram soja em 2023 tiveram retorno 23% maior. Timing é tudo.',
      ),
      NewsModel(
        id: '5',
        titulo: 'Crédito rural: novas linhas para irrigação chegam em março',
        categoria: 'ESTRATÉGIA',
        tempo: 'ontem às 14h',
        imagem: 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=800',
        resumo: 'Governo anuncia R\$ 2 bi em financiamento para sistemas de irrigação. Taxa de juros parte de 5,5% ao ano.',
      ),
      NewsModel(
        id: '6',
        titulo: 'Milho safrinha: janela ideal de plantio se fecha em 15 dias',
        categoria: 'MERCADO',
        tempo: 'há 1 dia',
        imagem: 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=800',
        resumo: 'Meteorologistas alertam: atraso no plantio pode comprometer até 30% da produtividade. Decisão precisa ser tomada agora.',
      ),
      NewsModel(
        id: '7',
        titulo: 'Blockchain rastreia café do pé até a xícara',
        categoria: 'TECH',
        tempo: 'há 2 dias',
        imagem: 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800',
        resumo: 'Cooperativa mineira implementa sistema que garante origem e qualidade do café, aumentando valor de exportação em 18%.',
      ),
    ];
  }

  static List<String> getCategories() {
    return [
      'TODAS',
      'MERCADO',
      'TECH',
      'PECUÁRIA',
      'ESTRATÉGIA',
      'XADREZ DO AGRO',
    ];
  }
}
