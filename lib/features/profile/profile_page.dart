import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificacoesMercado = true;
  bool _alertasPlantio = true;
  bool _resumoSemanal = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.verdeOliva,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'P',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Paola',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'leitora estratégica',
                    style: GoogleFonts.lora(
                      fontSize: 14,
                      color: AppColors.douradoTrigo,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            Text(
              'suas preferências',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppColors.douradoTrigo,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildPreferenceItem(
              isDark: isDark,
              titulo: 'Notificações de mercado',
              subtitulo: 'alertas de variação de preços',
              valor: _notificacoesMercado,
              onChanged: (val) => setState(() => _notificacoesMercado = val),
            ),
            
            _buildPreferenceItem(
              isDark: isDark,
              titulo: 'Alertas de janela de plantio',
              subtitulo: 'avisos sobre timing ideal',
              valor: _alertasPlantio,
              onChanged: (val) => setState(() => _alertasPlantio = val),
            ),
            
            _buildPreferenceItem(
              isDark: isDark,
              titulo: 'Resumo semanal por email',
              subtitulo: 'principais notícias da semana',
              valor: _resumoSemanal,
              onChanged: (val) => setState(() => _resumoSemanal = val),
            ),
            
            const SizedBox(height: 40),
            
            Text(
              'sobre o Raiz',
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
                'raiz não é um portal de notícias. é uma plataforma de inteligência '
                'para quem trata o agro como negócio, não como tradição.',
                style: GoogleFonts.lora(
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            Center(
              child: Text(
                'versão 1.0.0 · em desenvolvimento',
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceItem({
    required bool isDark,
    required String titulo,
    required String subtitulo,
    required bool valor,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark 
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.douradoTrigo.withValues(alpha: isDark ? 0.0 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.lora(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitulo,
                  style: GoogleFonts.lora(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: valor,
            onChanged: onChanged,
            activeThumbColor: AppColors.verdeOliva,
          ),
        ],
      ),
    );
  }
}
