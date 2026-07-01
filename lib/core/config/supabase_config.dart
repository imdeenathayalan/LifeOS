import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  const SupabaseConfig._();

  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://szatvkyjeghiwgxmjyje.supabase.co',
  );
  static const anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_Pl31G_UqyuJxqvHWWrz-vg_WyMZundI',
  );

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;

  static Future<void> initializeIfConfigured() async {
    if (!isConfigured) return;

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      debug: false,
    );
  }
}
