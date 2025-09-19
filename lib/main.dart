// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:kdrive/generated/codegen_loader.g.dart';
import 'package:kdrive/splash_screen.dart';
import 'package:kdrive/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  await init();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        Locale('zh'),
        Locale('vi'),
      ],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: MyApp(),
    ),
  );
}

/// 초기화 함수
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  await Supabase.initialize(
    url: "https://bmynnrryybrzbipdprmh.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJteW5ucnJ5eWJyemJpcGRwcm1oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM2NTIyNTksImV4cCI6MjA0OTIyODI1OX0.t3ci0hD07h0srEobU4NMqU-zXggY63JVJxza55S6leY',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: customTheme(),
      home: SplashScreen(),
    );
  }
}
