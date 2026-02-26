import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// ThemeData centralizado — light e dark mode completos
/// Decisão: usar Inter para UI e Merriweather para títulos (contraste editorial)
class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.brancoSuave,
      primaryColor: AppColors.verdeProfundo,
      colorScheme: const ColorScheme.light(
        primary: AppColors.verdeProfundo,
        secondary: AppColors.laranjaAmbar,
        surface: AppColors.brancoSuave,
        error: Colors.red,
      ),
      
      // Tipografia
      textTheme: TextTheme(
        displayLarge: GoogleFonts.merriweather(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.pretoElegante,
        ),
        displayMedium: GoogleFonts.merriweather(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.pretoElegante,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.pretoElegante,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.pretoElegante,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.pretoElegante,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.pretoElegante,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.verdeProfundo,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.brancoSuave,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.verdeProfundo,
        ),
        iconTheme: const IconThemeData(color: AppColors.verdeProfundo),
      ),
      
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.begeAreia,
        selectedColor: AppColors.verdeProfundo,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.verdeProfundo,
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
      scaffoldBackgroundColor: AppColors.pretoElegante,
      primaryColor: AppColors.begeAreia,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.begeAreia,
        secondary: AppColors.laranjaAmbar,
        surface: Color(0xFF1A1A1A),
        error: Colors.redAccent,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.merriweather(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.begeAreia,
        ),
        displayMedium: GoogleFonts.merriweather(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.begeAreia,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.begeAreia,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.begeAreia,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.begeAreia,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.begeAreia,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.laranjaAmbar,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pretoElegante,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.begeAreia,
        ),
        iconTheme: const IconThemeData(color: AppColors.begeAreia),
      ),
      
      cardTheme: CardThemeData(
        color: const Color(0xFF1A1A1A),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2A2A2A),
        selectedColor: AppColors.laranjaAmbar,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: AppColors.laranjaAmbar,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
      ),
    );
  }
}
