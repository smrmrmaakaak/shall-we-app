import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_wax_letter_screen.dart';

void main() {
  runApp(const ShallWeApp());
}

class ShallWeApp extends StatefulWidget {
  const ShallWeApp({super.key});

  @override
  State<ShallWeApp> createState() => _ShallWeAppState();
}

class _ShallWeAppState extends State<ShallWeApp> {
  Locale _currentLocale = const Locale('ko');

  void _setLocale(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shall We?',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      supportedLocales: const [
        Locale('ko', ''),
        Locale('en', ''),
        Locale('ja', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F6F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF850E22),
          primary: const Color(0xFF850E22),
        ),
        useMaterial3: true,
      ),
      home: HomeWaxLetterScreen(
        currentLocale: _currentLocale,
        onLocaleChange: _setLocale,
      ),
    );
  }
}
