import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// ThemeData com drama editorial — serif nos títulos, sans na UI
class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.fundoClaro,
      primaryColor: AppColors.verdeOliva,
      colorScheme: const ColorScheme.light(
        primary: AppColors.verdeOliva,
        secondary: AppColors.douradoTrigo,
        surface: AppColors.fundoClaro,
        error: Colors.red,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.1,
          color: AppColors.fundoEscuro,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.2,
          color: AppColors.fundoEscuro,
        ),
        titleLarge: GoogleFonts.lora(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.fundoEscuro,
        ),
        titleMedium: GoogleFonts.lora(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.fundoEscuro,
        ),
        bodyLarge: GoogleFonts.lora(
          fontSize: 16,
          color: AppColors.fundoEscuro,
        ),
        bodyMedium: GoogleFonts.lora(
          fontSize: 14,
          color: AppColors.fundoEscuro,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.verdeOliva,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.fundoClaro,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.verdeOliva,
        ),
        iconTheme: const IconThemeData(color: AppColors.verdeOliva),
      ),
      
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.fundoClaro,
        selectedItemColor: AppColors.verdeOliva,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.fundoEscuro,
      primaryColor: AppColors.cremeSol,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cremeSol,
        secondary: AppColors.douradoTrigo,
        surface: Color(0xFF1A1A1A),
        error: Colors.redAccent,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.1,
          color: AppColors.cremeSol,
        ),
        displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.2,
          color: AppColors.cremeSol,
        ),
        titleLarge: GoogleFonts.lora(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.cremeSol,
        ),
        titleMedium: GoogleFonts.lora(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.cremeSol,
        ),
        bodyLarge: GoogleFonts.lora(
          fontSize: 16,
          color: AppColors.cremeSol,
        ),
        bodyMedium: GoogleFonts.lora(
          fontSize: 14,
          color: AppColors.cremeSol,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.douradoTrigo,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.fundoEscuro,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.cremeSol,
        ),
        iconTheme: const IconThemeData(color: AppColors.cremeSol),
      ),
      
      cardTheme: CardThemeData(
        color: const Color(0xFF1A1A1A),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: AppColors.douradoTrigo,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
      ),
    );
  }
}
