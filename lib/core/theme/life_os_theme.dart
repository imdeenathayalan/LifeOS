import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LifeOSTheme {
  const LifeOSTheme._();

  static const _primary = Color(0xFF3157D5);
  static const _success = Color(0xFF16834A);
  static const _warning = Color(0xFFB7791F);
  static const _danger = Color(0xFFC7353C);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      primary: _primary,
      surface: const Color(0xFFFBFCFE),
      error: _danger,
    );

    return _base(scheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      extensions: const [
        LifeOSColors(success: _success, warning: _warning, danger: _danger),
      ],
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
      primary: const Color(0xFF8EA2FF),
      surface: const Color(0xFF111318),
      error: const Color(0xFFFFB4AB),
    );

    return _base(scheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B0D11),
      extensions: const [
        LifeOSColors(
          success: Color(0xFF70D99B),
          warning: Color(0xFFE7BE6A),
          danger: Color(0xFFFF9AA2),
        ),
      ],
    );
  }

  static ThemeData _base(ColorScheme scheme) {
    final textTheme = GoogleFonts.interTextTheme().apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      visualDensity: VisualDensity.standard,
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant.withOpacity(0.7)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class LifeOSColors extends ThemeExtension<LifeOSColors> {
  const LifeOSColors({
    required this.success,
    required this.warning,
    required this.danger,
  });

  final Color success;
  final Color warning;
  final Color danger;

  @override
  LifeOSColors copyWith({Color? success, Color? warning, Color? danger}) {
    return LifeOSColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  LifeOSColors lerp(ThemeExtension<LifeOSColors>? other, double t) {
    if (other is! LifeOSColors) return this;
    return LifeOSColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}
