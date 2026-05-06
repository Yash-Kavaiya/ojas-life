import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

abstract final class OjasTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: OjasColors.saffron,
        onPrimary: OjasColors.cream,
        secondary: OjasColors.gold,
        onSecondary: OjasColors.deepPurple,
        tertiary: OjasColors.lotus,
        surface: OjasColors.surfacePurple,
        onSurface: OjasColors.textPrimary,
        error: OjasColors.error,
        primaryContainer: OjasColors.saffronDark,
        onPrimaryContainer: OjasColors.goldLight,
        secondaryContainer: OjasColors.cardPurple,
        onSecondaryContainer: OjasColors.textPrimary,
      ),
      scaffoldBackgroundColor: OjasColors.deepPurple,
      appBarTheme: const AppBarTheme(
        backgroundColor: OjasColors.deepPurple,
        foregroundColor: OjasColors.cream,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: OjasTextStyles.headlineMedium,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: OjasColors.cream),
      ),
      cardTheme: CardThemeData(
        color: OjasColors.cardPurple,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusLg),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: OjasColors.saffron,
          foregroundColor: OjasColors.cream,
          minimumSize: const Size.fromHeight(OjasDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OjasDimensions.radiusFull),
          ),
          textStyle: OjasTextStyles.labelLarge,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: OjasColors.saffron,
          minimumSize: const Size.fromHeight(OjasDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OjasDimensions.radiusFull),
          ),
          side: const BorderSide(color: OjasColors.saffron, width: 1.5),
          textStyle: OjasTextStyles.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: OjasColors.saffron,
          textStyle: OjasTextStyles.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: OjasColors.surfacePurple,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
          borderSide: const BorderSide(color: OjasColors.saffron, width: 1.5),
        ),
        labelStyle: OjasTextStyles.bodyMedium,
        hintStyle: const TextStyle(color: OjasColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: OjasDimensions.md,
          vertical: OjasDimensions.md,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: OjasColors.surfacePurple,
        indicatorColor: OjasColors.saffron.withValues(alpha: 0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: OjasColors.saffron, size: OjasDimensions.iconMd);
          }
          return const IconThemeData(color: OjasColors.textMuted, size: OjasDimensions.iconMd);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return OjasTextStyles.labelMedium.copyWith(color: OjasColors.saffron);
          }
          return OjasTextStyles.labelMedium;
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: OjasColors.cardPurple,
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: OjasColors.cardPurple,
        selectedColor: OjasColors.saffron.withValues(alpha: 0.2),
        labelStyle: OjasTextStyles.labelMedium,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusFull),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: OjasTextStyles.displayLarge,
        displayMedium: OjasTextStyles.displayMedium,
        headlineLarge: OjasTextStyles.headlineLarge,
        headlineMedium: OjasTextStyles.headlineMedium,
        bodyLarge: OjasTextStyles.bodyLarge,
        bodyMedium: OjasTextStyles.bodyMedium,
        bodySmall: OjasTextStyles.bodySmall,
        labelLarge: OjasTextStyles.labelLarge,
        labelMedium: OjasTextStyles.labelMedium,
      ),
    );
  }
}
